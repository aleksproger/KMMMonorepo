//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import GitHooksKit
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class BranchNameCheckerTests: XCTestCase {
	private let git = GitMock()

	private lazy var sut = BranchNameChecker(git: git)

	func test_Run_WhenBranchContainsJiraTask_DoesNotThrowError() throws {
		git.returnsBranchName = "feature/user/TASK-0/0"

		XCTAssertNoThrow(try sut.run())
	}

	func test_Run_WhenBranchStartsNotFromFeature_ThrowsError() throws {
		git.returnsBranchName = "any_feature/any/some-other"

		XCTAssertThrowsError(try sut.run())
	}

	func test_Run_WhenBranchContainsJiraTask_ThrowsError() throws {
		git.returnsBranchName = "feature/any/some-other"

		XCTAssertThrowsError(try sut.run())
	}
}
