//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import ToolsCore
import ToolsCoreTestKit
import XCTest

final class JIRATests: XCTestCase {
	private lazy var sut = JIRA(git: git)
	private let git = GitMock()

	func test_ExtractJiraTaskFromBranch_WhenBranchNameContainsTask_ReturnsIt() throws {
		git.returnsBranchName = "feature/johndoe/ATHENADEV-1"

		let result = try sut.jiraTaskFromGit()

		XCTAssertEqual(
			result,
			"ATHENADEV-1"
		)
	}

	func test_ExtractJiraTaskFromBranch_WhenBranchNameContainsTask_AndPRNumber_ReturnsIt() throws {
		git.returnsBranchName = "feature/johndoe/ATHENADEV-1/0"

		let result = try sut.jiraTaskFromGit()

		XCTAssertEqual(
			result,
			"ATHENADEV-1/0"
		)
	}

	func test_ExtractJiraTaskFromBranch_WhenBranchDoesNotContainTask_ReturnsNil() throws {
		git.returnsBranchName = "feature/johndoe/0"

		let result = try sut.jiraTaskFromGit()

		XCTAssertNil(result)
	}

	func test_ExtractJiraTaskFromBranch_WhenBranchDoesNotContainContributorName_ReturnsNil() throws {
		git.returnsBranchName = "feature/ATHENADEV-1/0"

		let result = try sut.jiraTaskFromGit()

		XCTAssertNil(result)
	}

	func test_ExtractJiraTaskFromBranch_WhenBranchDoesNotContainFeatureKeyword_ReturnsNil() throws {
		git.returnsBranchName = "johndoe/ATHENADEV-1/0"

		let result = try sut.jiraTaskFromGit()

		XCTAssertNil(result)
	}
}
