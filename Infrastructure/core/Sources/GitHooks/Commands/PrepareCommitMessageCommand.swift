//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import Foundation
import GitHooksKit
import ToolsCore

extension GitHooksCommand {
	struct PrepareCommitMessageCommand: ParsableCommand {
		static var configuration = CommandConfiguration(
			commandName: "prepare-commit-msg",
			abstract: "Use git hooks to prepare commit command"
		)

		@Argument(help: "Commit message temporary file path")
		var commitMessageFilePath: String

		mutating func run() throws {
			let task = PrepareCommitMessageTemplate()
			try task.run(commitMessageFilePath: commitMessageFilePath)
		}
	}
}
