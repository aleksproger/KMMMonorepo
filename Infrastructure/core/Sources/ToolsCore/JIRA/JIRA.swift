//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public struct JIRA {
	private let git: Git

	public init(
		git: Git = GitImpl()
	) {
		self.git = git
	}

	public func jiraTaskFromGit() throws -> String? {
		let branchName = try git.branchName()

		let queueNameGroup = "queueNameGroup"
		let ticketAndBranchNumberGroup = "ticketAndBranchNumberGroup"
		let pattern = "^feature/\\w+/(?<\(queueNameGroup)>[a-zA-Z]+)-(?<\(ticketAndBranchNumberGroup)>\\d*(?:/\\d)?)$"
		guard let regex = try? NSRegularExpression(
			pattern: pattern
		)
		else {
			return nil
		}

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
