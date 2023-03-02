//
//  Copyright © 2021 Sberbank. All rights reserved.
//

public final class ZipUnarchiver: Unarchiver {
	private let shell: Shell

	public init(shell: Shell) {
		self.shell = shell
	}

	public func unarchive(from sourcePath: String, to destinationPath: String) throws {
		try shell.bash(to: .unarchive(from: sourcePath, to: destinationPath))
	}
}

extension ShellCommand {
	fileprivate static func unarchive(from: String, to: String) -> Self {
		var command = tar()
		command.append(argument: "-uo")
		command.append(argument: "-qq")
		command.append(argument: "-d")
		command.append(argument: to)
		command.append(argument: from)
		command.append(argument: "-x")
		command.append(argument: "__MACOSX/*")
		return command
	}

	private static func tar() -> ShellCommand {
		ShellCommand("unzip")
	}
}
