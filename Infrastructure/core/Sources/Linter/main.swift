//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import Foundation
import LinterKit
import ToolsCore

struct LinterCommand: ParsableCommand {
	static var configuration = CommandConfiguration(
		commandName: "lint",
		abstract: "Lint files"
	)

	mutating func run() throws {
		let linter = SwiftLinter()
		try linter.run()
	}
}

LinterCommand.main()
