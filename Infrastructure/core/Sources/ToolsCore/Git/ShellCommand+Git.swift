//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

extension ShellCommand {
	static func topLevel() -> Self {
		var command = git(allowingPrompt: false)
		command.append(arguments: ["rev-parse", "--show-toplevel"])
		return command
	}

	static func branchName() -> Self {
		var command = git(allowingPrompt: false)
		command.append(arguments: ["rev-parse", "--abbrev-ref", "HEAD"])
		return command
	}

	static func diff(
		filter: [FileStatus]? = nil
	) -> ShellCommand {
		var command = git(allowingPrompt: false)
		command.append(arguments: ["diff", "--name-only", "--cached"])
		if let filter = filter, !filter.isEmpty {
			let filterString = filter
				.map { $0.rawValue.lowercased() }
				.joined()
			command.append(argument: "--diff-filter=\(filterString)")
		}
		return command
	}

	static func mergeBase(firstBranch: String, secondBranch: String) -> Self {
		var command = git(allowingPrompt: false)
		command.append(argument: "merge-base")
		command.append(arguments: [firstBranch, secondBranch])
		return command
	}

	static func log(parameters: [String]) -> Self {
		var command = git(allowingPrompt: false)
		command.append(argument: "log")
		command.append(arguments: parameters)
		return command
	}

	private static func git(allowingPrompt: Bool) -> ShellCommand {
		ShellCommand(allowingPrompt ? "git" : "env GIT_TERMINAL_PROMPT=0 git")
	}
}
