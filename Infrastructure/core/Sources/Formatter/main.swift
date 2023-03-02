//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ArgumentParser
import FormatterKit
import ToolsCore

struct FormatterCommand: ParsableCommand {
	static var configuration = CommandConfiguration(
		commandName: "format",
		abstract: "Format files"
	)

	mutating func run() throws {
		let swiftFormatter = SwiftFormater()
		try swiftFormatter.run()
	}
}

FormatterCommand.main()
