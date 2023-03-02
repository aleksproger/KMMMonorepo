//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import GenerateProjectKit
import GitHooksKit
import ToolsCore

extension GitHooksCommand {
	struct PostCheckoutCommand: AsyncParsableCommand {
		static var configuration = CommandConfiguration(
			commandName: "post-checkout",
			abstract: "Use git hook to perform additionl actions after checkout"
		)

		mutating func run() async throws {
			let commands = AsyncCommandSequence(
				errorHeader: "Errors occured during generating .xcodeproj files",
				commands: [
					XcodeGen(mode: .fast).run,
				],
				errorFooter: "Check the correctness of projects specifications"
			)

			try await commands.run()
		}
	}
}
