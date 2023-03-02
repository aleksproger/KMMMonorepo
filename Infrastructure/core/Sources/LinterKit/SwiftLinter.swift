//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public struct SwiftLinter {
	private let configPath: String
	private let git: Git
	private let shell: Shell

	public init(
		configPath: String = ".swiftlint.yml",
		git: Git = GitImpl(),
		shell: Shell = ShellImpl()
	) {
		self.configPath = configPath
		self.git = git
		self.shell = shell
	}

	public func run() throws {
		shell.print("Start swiftlint")
		let files = try git.changedFiles()
		guard !files.isEmpty else {
			shell.print("Nothing to lint")
			return
		}

		files.forEach {
			shell.print("Lint: \($0)")
		}

		try runSwiftLint(forFilePaths: files)
	}

	private func runSwiftLint(
		forFilePaths filePaths: [String]
	) throws {
		let topLevel = try git.topLevel()
		try shell.bash(to: .swiftlint(
			config: "\(topLevel)/\(configPath)",
			files: filePaths
		))
	}
}
