//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore
import XCTest

extension ShellCommand {
	public func assertMintRun(
		package: String,
		version: String,
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertTrue(
			command.starts(with: "mint run \(package)@\(version)"),
			"Command does not contain mint run with specific package and version. Got: \"\(command)\"",
			file: file,
			line: line
		)
	}
}
