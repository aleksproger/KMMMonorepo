//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

extension ShellCommand {
	public static func mint(packageName: String, version: String) -> ShellCommand {
		let command = "mint run \(packageName)@\(version)"
		return ShellCommand(command)
	}
}
