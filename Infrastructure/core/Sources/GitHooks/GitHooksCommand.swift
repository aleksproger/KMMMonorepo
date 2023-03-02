//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import Foundation

@main
struct GitHooksCommand: AsyncParsableCommand {
	static var configuration = CommandConfiguration(
		commandName: "githooks",
		abstract: "Use git hooks to check commit",
		subcommands: [
			PreCommitCommand.self,
			PrepareCommitMessageCommand.self,
			PostCheckoutCommand.self,
		]
	)
}
