//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import LinterKit
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ShellSwiftlintTest: XCTestCase {
	func test_MakeCommand_ContainsMintExecution() {
		let sut: ShellCommand = .swiftlint(config: "any", files: [])

		sut.assertMintRun(package: "realm/swiftlint", version: "0.39.2")
	}

	func test_MakeCommand_ContainsSwiftlintConfigArgument() {
		let sut: ShellCommand = .swiftlint(config: "theConfig", files: [])

		XCTAssertTrue(
			sut.command.contains("--config theConfig"),
			"Expected to contain config argument, but got: \(sut.command)"
		)
	}

	func test_MakeCommand_EscapedFilePaths() {
		let sut: ShellCommand = .swiftlint(
			config: "any",
			files: ["First.swift", "Second.swift"]
		)

		XCTAssertTrue(
			sut.command.contains("-- \"First.swift\" \"Second.swift\""),
			"Expected to contain escaped files, but got: \(sut.command)"
		)
	}

	func test_MakeCommand_TreatsWarningsAsErrors() {
		let sut: ShellCommand = .swiftlint(
			config: "any",
			files: ["Any.swift"]
		)

		XCTAssertTrue(
			sut.command.contains("--strict"),
			"Expected contain strict argument to treat warnings as errors"
		)
	}
}
