//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public struct BranchNameChecker {
	enum PreCommitHookError: LocalizedError {
		case branchNameDoesNotContainValidJiraTask(_ branchName: String)

		var errorDescription: String? {
			switch self {
			case .branchNameDoesNotContainValidJiraTask:
				return """
				\u{001B}[1;31m
				Branch name does not contain valid Jira task.
				Branch name is supposed to have a form \
				\"feature/<surname>/<JIRA queue name>-<task number in JIRA>/<branch number>\"
				If you know what you are doing, just ignore this message\u{001B}[0m\n
				"""
			}
		}
	}

	private let git: Git

	public init(git: Git = GitImpl()) {
		self.git = git
	}

	public func run() throws {
		try checkBranchName()
	}

	private func checkBranchName() throws {
		let branchName = try git.branchName()
		let jiraTask = try extractJiraTask(fromBranch: branchName)
		if jiraTask == nil {
			throw PreCommitHookError.branchNameDoesNotContainValidJiraTask(branchName)
		}
	}

	private func extractJiraTask(fromBranch branchName: String) throws -> String? {
		let queueNameGroup = "queueNameGroup"
		let ticketAndBranchNumberGroup = "ticketAndBranchNumberGroup"
		let pattern = "^feature/\\w+/(?<\(queueNameGroup)>[a-zA-Z]+)-(?<\(ticketAndBranchNumberGroup)>\\d*/\\d+)$"
		let regex = try NSRegularExpression(
			pattern: pattern
		)

		guard
			let result = regex.firstMatch(
				in: branchName,
				range: NSRange(branchName.startIndex..., in: branchName)
			),
			let queueNameRange = Range(
				result.range(withName: queueNameGroup),
				in: branchName
			),
			let numbersRange = Range(
				result.range(withName: ticketAndBranchNumberGroup),
				in: branchName
			)
		else {
			return nil
		}

		return "\(String(branchName[queueNameRange]))-\(String(branchName[numbersRange]))"
	}
}
