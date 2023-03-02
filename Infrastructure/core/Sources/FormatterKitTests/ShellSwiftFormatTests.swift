//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import FormatterKit
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ShellSwiftFormatTests: XCTestCase {
	func test_MakeCommand_ContainsMintExecution() {
		let sut: ShellCommand = .swiftformat(
			config: "config",
			version: "5.1",
			files: []
		)

		sut.assertMintRun(package: "nicklockwood/SwiftFormat", version: "0.47.11")
	}
}
