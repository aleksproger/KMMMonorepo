//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public struct ShellCommand {
	public var command: String

	public init(_ command: String) {
		self.command = command
	}

	public mutating func append(
		arguments: [String],
		escaping: Bool = false
	) {
		if escaping {
			command.append(arguments: arguments)
		} else {
			command += " " + arguments.joined(separator: " ")
		}
	}

	public mutating func append(
		argument: String,
		escaping: Bool = false
	) {
		append(
			arguments: [argument],
			escaping: escaping
		)
	}
}

extension String {
	private func appending(argument: String) -> String {
		"\(self) \"\(argument)\""
	}

	private func appending(arguments: [String]) -> String {
		appending(argument: arguments.joined(separator: "\" \""))
	}

	fileprivate mutating func append(argument: String) {
		self = appending(argument: argument)
	}

	fileprivate mutating func append(arguments: [String]) {
		self = appending(arguments: arguments)
	}
}
