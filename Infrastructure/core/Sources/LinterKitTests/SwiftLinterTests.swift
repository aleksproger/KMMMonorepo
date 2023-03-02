//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import LinterKit
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class SwiftLinterTests: XCTestCase {
	private lazy var sut = SwiftLinter(
		git: git,
		shell: shell
	)

	private let git = GitMock()
	private let shell = ShellMock()

	func test_Run_LogsStartLintingMessage() throws {
		try sut.run()

		XCTAssertEqual(shell.printedItems.first?.first as? String, "Start swiftlint")
	}

	func test_Run_WhenWhereAreNotFilesToLint_LogsIt() throws {
		git.returnsChangedFiles = []

		try sut.run()

		XCTAssertEqual(
			shell.printedItems.last?.first as? String,
			"Nothing to lint"
		)
	}

	func test_Run_CallsSwiftlintBashCommand() throws {
		git.returnsChangedFiles = ["Any.swift"]
		git.returnsTopLevel = "root"

		try sut.run()

		XCTAssertEqual(
			shell.command,
			ShellCommand.swiftlint(
				config: "root/.swiftlint.yml",
				files: ["Any.swift"]
			).command
		)
	}
}
