//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public struct PrepareCommitMessageTemplate {
	private let git: Git
	private let jira: JIRA

	public init(
		git: Git = GitImpl(),
		jira: JIRA = JIRA(git: GitImpl())
	) {
		self.git = git
		self.jira = jira
	}

	public func run(
		commitMessageFilePath: String
	) throws {
		let commitMessageFileURL = URL(fileURLWithPath: "\(try git.topLevel())/\(commitMessageFilePath)")
		let defaultCommitMessage = try String(contentsOf: commitMessageFileURL)

		let branchName = try git.branchName()
		let commitTitle = try jira.jiraTaskFromGit() ?? branchName
		let commitMessage = String(format: commitMessageTemplate, commitTitle) + defaultCommitMessage

		try? commitMessage.write(
			to: commitMessageFileURL,
			atomically: false,
			encoding: .utf8
		)
	}
}

private let commitMessageTemplate = """
%@: <короткое описание изменений>\n
**Причина**:
<Описание причины в неопределенной форме>.

**Содержание**:
<Описание содержания пулл-реквеста. Можно тезисно>.
"""
