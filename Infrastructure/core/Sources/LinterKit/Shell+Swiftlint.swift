//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

extension ShellCommand {
	static func swiftlint(
		config: String,
		files: [String]
	) -> Self {
		var command = mint(packageName: "realm/swiftlint", version: "0.39.2")
		command.append(argument: "lint")
		command.append(arguments: ["--config", config])
		command.append(argument: "--strict")
		let escapedFiles = files.map { "\"\($0)\"" }
		command.append(arguments: ["--"] + escapedFiles)
		return command
	}
}
