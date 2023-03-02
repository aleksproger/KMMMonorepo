//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public final class GitMock: Git {
	public enum Input: Equatable {
		case topLevel
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var returnsTopLevel = ""
	public func topLevel() throws -> String {
		inputs.append(.topLevel)
		return returnsTopLevel
	}

	public var returnsBranchName = ""

	public func branchName() throws -> String {
		returnsBranchName
	}

	public var returnsChangedFiles: [String] = []

	public func changedFiles() throws -> [String] {
		returnsChangedFiles
	}

	public func findFirstCommonCommit(
		firstBranch _: String,
		secondBranch _: String
	) throws -> String {
		""
	}

	public func commitsSince(
		commit _: String,
		in _: String
	) throws -> [String] {
		[]
	}
}
