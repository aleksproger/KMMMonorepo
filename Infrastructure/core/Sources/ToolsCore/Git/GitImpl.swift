//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public struct GitImpl: Git {
	enum GitError: LocalizedError {
		case missingBranch

		var errorDescription: String? {
			switch self {
			case .missingBranch:
				return "Git branch name is missing"
			}
		}
	}

	private let shell: Shell

	public init(
		shell: Shell = ShellImpl()
	) {
		self.shell = shell
	}

	public func topLevel() throws -> String {
		let path = try shell.bash(to: .topLevel())
		return path.trimmingCharacters(in: .newlines)
	}

	public func branchName() throws -> String {
		let branchName = try shell.bash(to: .branchName())
		guard !branchName.isEmpty else {
			throw GitError.missingBranch
		}
		return branchName.trimmingCharacters(in: .newlines)
	}

	public func changedFiles() throws -> [String] {
		let listOfFlies = try shell.bash(to: .diff(filter: [.deleted]))
		let topLevel = try self.topLevel()
		return listOfFlies
			.split { $0.isNewline }
			.filter { $0.hasSuffix(".swift") }
			.map { "\(topLevel)/\($0)" }
	}

	public func findFirstCommonCommit(
		firstBranch: String,
		secondBranch: String
	) throws -> String {
		try shell.bash(to: .mergeBase(firstBranch: firstBranch, secondBranch: secondBranch))
	}

	public func commitsSince(commit: String, in branch: String) throws -> [String] {
		let logParameters = [
			"--pretty=format:%s",
			"\(commit)..\(branch)",
		]
		return try shell.bash(to: .log(parameters: logParameters)).split(separator: "\n").map(String.init)
	}
}

extension Array where Element == Substring {
	fileprivate var fileStatus: FileStatus? {
		let rawFileStatus = first
		let rawStatusType = rawFileStatus?.first // first symbol is type, others are percentage of changes
		return rawStatusType
			.map(String.init)
			.flatMap(FileStatus.init(rawValue:))
	}
}
