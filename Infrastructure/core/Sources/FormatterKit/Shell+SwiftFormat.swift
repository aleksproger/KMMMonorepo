//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

extension ShellCommand {
	static func swiftformat(
		config: String,
		version: String,
		files: [String]
	) -> Self {
		var command = mint(packageName: "nicklockwood/SwiftFormat", version: "0.47.11")
		command.append(argument: "--config")
		command.append(argument: config, escaping: true)
		command.append(arguments: ["--swiftversion", version])
		command.append(arguments: files, escaping: true)
		return command
	}
}
