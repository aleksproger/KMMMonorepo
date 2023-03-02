//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public struct SwiftFormater {
	private let git: Git
	private let shell: Shell
	let configPath: String

	public init(
		configPath: String = ".swiftformat.config",
		shell: Shell = ShellImpl(),
		git: Git = GitImpl()
	) {
		self.configPath = configPath
		self.shell = shell
		self.git = git
	}

	public func run() throws {
		shell.print("Start format")
		let files = try git.changedFiles()
		let topLevel = try git.topLevel()
		guard !files.isEmpty else {
			shell.print("Nothing to format")
			return
		}

		files.forEach {
			shell.print("Format file: \"\($0)\"")
		}

		try shell.bash(
			to: .swiftformat(
				config: "\(topLevel)/\(configPath)",
				version: Tools.swiftVersion,
				files: files
			),
			at: topLevel
		)
	}
}
