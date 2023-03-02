//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public final class ShellMock: Shell {
	public init() {}

	public private(set) var command: String?
	public var commandResult = ""

	@discardableResult
	public func bash(
		to command: String,
		arguments _: [String],
		at _: String,
		outputHandle _: FileHandle? = nil,
		errorHandle _: FileHandle? = nil
	) throws -> String {
		self.command = command
		return commandResult
	}

	public private(set) var printedItems: [[Any]] = []

	public func print(
		_ items: [Any],
		separator _: String,
		terminator _: String,
		outputHandle _: FileHandle
	) {
		printedItems.append(items)
	}
}
