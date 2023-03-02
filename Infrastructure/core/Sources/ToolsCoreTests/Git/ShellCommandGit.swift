//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import ToolsCore
import XCTest

final class ShellCommandGit: XCTestCase {
	func test_Diff_ContainsOnlyFilesNamesFlag() {
		let sut: ShellCommand = .diff()

		XCTAssertTrue(
			sut.command.contains("--name-only"),
			"Expected to contain name only flags to get list of files without statuses"
		)
	}

	func test_Diff_ContainsChachedFlag() {
		let sut: ShellCommand = .diff()

		XCTAssertTrue(
			sut.command.contains("--cached"),
			"Expected to contain cached flag to get only staged changes"
		)
	}

	func test_Diff_WhenFilterIsNil_DoesNotContainDiffFilterFlag() {
		let sut: ShellCommand = .diff()

		XCTAssertFalse(
			sut.command.contains("--diff-filter="),
			"Expected to not contain diff filter flag"
		)
	}

	func test_Diff_WhenFilterExists_ContainsDiffFilterArgumentWithExpectedFileStatuses() {
		let sut: ShellCommand = .diff(filter: [.modified, .added])

		XCTAssertTrue(
			sut.command.contains("--diff-filter=ma"),
			"Expected to contain diff filter argument for files with modified and added status"
		)
	}
}
