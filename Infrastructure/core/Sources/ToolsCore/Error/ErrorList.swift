//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

public struct ErrorList: LocalizedError {
	public let header: String?
	public let errors: [Error]
	public let footer: String?

	public init?(
		header: String? = nil,
		errors: [Error],
		footer: String? = nil
	) {
		guard !errors.isEmpty else {
			return nil
		}
		self.header = header
		self.errors = errors
		self.footer = footer
	}

	public var errorDescription: String? {
		var result = header?
			.asciiAttributed(color: .yellow)
			.appending("\n") ?? ""
		for (offset, error) in errors.enumerated() {
			result += "\(offset + 1)/\(errors.count) error:"
				.asciiAttributed(color: .yellow)
				+ "\n"
			result += error.localizedErrorDescription
				+ "\n"
		}
		if let footer = footer {
			result += footer.asciiAttributed(color: .yellow)
		}
		return result
	}
}
