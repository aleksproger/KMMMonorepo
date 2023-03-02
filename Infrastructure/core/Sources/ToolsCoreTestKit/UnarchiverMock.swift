//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import ToolsCore

public final class UnarchiverMock: Unarchiver {
	public enum Input: Equatable {
		case unarchive(from: String, to: String)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public func unarchive(from: String, to: String) throws {
		inputs.append(.unarchive(from: from, to: to))
	}
}
