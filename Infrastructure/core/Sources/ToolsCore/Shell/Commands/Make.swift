//
//  Created by Kotov Max on 04.08.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

extension ShellCommand {
	public static func make(
		command makeCommand: String
	) -> ShellCommand {
		let command = "make \(makeCommand)"
		return ShellCommand(command)
	}
}

extension ShellCommand {
	public mutating func append(
		makeArgument: String,
		value: String
	) {
		append(argument: "\(makeArgument)=\(value)")
	}
}
