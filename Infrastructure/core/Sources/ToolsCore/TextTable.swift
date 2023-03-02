//
//  Created by Kalintsev Daniel on 13.05.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

typealias Regex = NSRegularExpression

private let strippingPattern = "\\\u{001B}\\[([0-9][0-9]?m|[0-9](;[0-9]*)*m)"

// We can safely force try this regex because the pattern has be tested to work.
// swiftlint:disable:next force_try
private let strippingRegex = try! Regex(pattern: strippingPattern, options: [])

extension String {
	private func stripped() -> String {
		let length = (self as NSString).length
		return strippingRegex.stringByReplacingMatches(
			in: self,
			options: [],
			range: NSRange(location: 0, length: length),
			withTemplate: ""
		)
	}
}

public struct TextTable {
	private var columns: [TextTableColumn]
	public var columnFence = "|"
	public var rowFence = "-"
	public var cornerFence = "+"
	public var header: String?
	public var footer: String?

	public init(
		columns: [TextTableColumn],
		header: String? = nil,
		footer: String? = nil
	) {
		self.columns = columns
		self.header = header
		self.footer = footer
	}

	public init<T: TextTableRepresentable>(
		objects: [T],
		header: String? = nil,
		footer: String? = nil
	) {
		self.header = header ?? T.tableHeader
		self.footer = footer ?? T.tableFooter
		columns = T.columnHeaders.map { TextTableColumn(header: $0) }
		objects.forEach { addRow(values: $0.tableValues) }
	}

	public mutating func addRow(values: [CustomStringConvertible]) {
		let values = values.count >= columns.count
			? values
			: values + [CustomStringConvertible](
				repeating: "",
				count: columns.count - values.count
			)

		columns = zip(columns, values).map { column, value in
			var column = column
			column.values.append(value.description)
			return column
		}
	}

	public mutating func addRows(values: [[CustomStringConvertible]]) {
		for index in 0 ..< columns.count {
			let columnValues: [String] = values.map { row in
				index < row.count ? row[index].description : ""
			}
			columns[index].values.append(contentsOf: columnValues)
		}
	}

	public mutating func clearRows() {
		for index in 0 ..< columns.count {
			columns[index].values = []
		}
	}

	public func render() -> String {
		let separator = fence(
			strings: columns.map {
				repeatElement(
					rowFence,
					count: $0.width() + 2
				).joined()
			},
			separator: cornerFence
		)

		let top = renderTableHeaderOrFooter(header) ?? separator
		let bottom = renderTableHeaderOrFooter(footer) ?? separator

		let columnHeaders = fence(
			strings: columns.map { " \($0.header.withPadding(count: $0.width())) " },
			separator: columnFence
		)

		let values = columns.isEmpty
			? ""
			: (0 ..< columns.first!.values.count)
			.map { rowIndex in
				fence(
					strings: columns.map { " \($0.values[rowIndex].withPadding(count: $0.width())) " },
					separator: columnFence
				)
			}
			.paragraph()

		return [
			top,
			columnHeaders,
			separator,
			values,
			bottom,
		].paragraph()
	}

	private func renderTableHeaderOrFooter(_ element: String?) -> String? {
		guard let element = element else {
			return nil
		}

		let calculatewidth: (Int, TextTableColumn) -> Int = { $0 + $1.width() + 2 }
		let separator = cornerFence + repeatElement(
			rowFence,
			count: columns.reduce(0, calculatewidth) + columns.count - 1
		).joined() + cornerFence
		let separatorCount = separator.count
		let title = fence(
			strings: [" \(element.withPadding(count: separatorCount - 4)) "],
			separator: columnFence
		)

		return [
			separator,
			title,
			separator,
		].paragraph()
	}
}

public struct TextTableColumn {
	public var header: String {
		didSet {
			computeWidth()
		}
	}

	fileprivate var values: [String] = [] {
		didSet {
			computeWidth()
		}
	}

	public init(header: String) {
		self.header = header
		computeWidth()
	}

	public func width() -> Int {
		precomputedWidth
	}

	private var precomputedWidth: Int = 0

	private mutating func computeWidth() {
		let valueLengths = [header.strippedLength()] + values.map { $0.strippedLength() }
		if let max = valueLengths.max() {
			precomputedWidth = max
		}
	}
}

public protocol TextTableRepresentable {
	static var tableHeader: String? { get }
	static var tableFooter: String? { get }
	static var columnHeaders: [String] { get }

	var tableValues: [CustomStringConvertible] { get }
}

extension TextTableRepresentable {
	public static var tableHeader: String? {
		nil
	}

	public static var tableFooter: String? {
		nil
	}
}

private func fence(strings: [String], separator: String) -> String {
	separator + strings.joined(separator: separator) + separator
}

extension Array where Element: TextTableRepresentable {
	public func renderTextTable() -> String {
		let table = TextTable(objects: self)
		return table.render()
	}
}

extension String {
	fileprivate func withPadding(count: Int) -> String {
		let length = self.strippedLength()

		if length < count {
			return self +
				repeatElement(" ", count: count - length).joined()
		}
		return self
	}

	fileprivate func strippedLength() -> Int {
		stripped().count
	}
}

extension Array where Element: CustomStringConvertible {
	fileprivate func paragraph() -> String {
		self.map(\.description).joined(separator: "\n")
	}
}
