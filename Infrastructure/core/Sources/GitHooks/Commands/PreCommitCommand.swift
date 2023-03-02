//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import FormatterKit
import GitHooksKit
import LinterKit
import ToolsCore

extension GitHooksCommand {
	struct PreCommitCommand: ParsableCommand {
		static var configuration = CommandConfiguration(
			commandName: "pre-commit",
			abstract: "Use git hooks to check commit"
		)

		mutating func run() throws {
			let commands = CommandSequence(
				errorHeader: "Pre commit errors occurred",
				commands: [
					BranchNameChecker().run,
					SwiftFormater().run,
					SwiftLinter().run,
				],
				errorFooter: "Please fix errors before commit"
			)
			try commands.run()
		}
	}
}
