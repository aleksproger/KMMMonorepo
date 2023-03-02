//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public protocol Shell {
	@discardableResult
	func bash(
		to command: String,
		arguments: [String],
		at path: String,
		outputHandle: FileHandle?,
		errorHandle: FileHandle?
	) throws -> String

	func print(
		_ items: [Any],
		separator: String,
		terminator: String,
		outputHandle: FileHandle
	)
}

extension Shell {
	@discardableResult
	public func bash(
		to command: String,
		arguments: [String] = [],
		at path: String = ".",
		outputHandle: FileHandle? = nil,
		errorHandle: FileHandle? = nil
	) throws -> String {
		try bash(
			to: command,
			arguments: arguments,
			at: path,
			outputHandle: outputHandle,
			errorHandle: errorHandle
		)
	}

	@discardableResult
	public func bash(
		to commands: [String],
		at path: String = ".",
		outputHandle: FileHandle? = nil,
		errorHandle: FileHandle? = nil
	) throws -> String {
		let command = commands.joined(separator: " && ")

		return try bash(
			to: command,
			at: path,
			outputHandle: outputHandle,
			errorHandle: errorHandle
		)
	}

	@discardableResult
	public func bash(
		to command: ShellCommand,
		at path: String = ".",
		outputHandle: FileHandle? = nil,
		errorHandle: FileHandle? = nil
	) throws -> String {
		try bash(
			to: command.command,
			at: path,
			outputHandle: outputHandle,
			errorHandle: errorHandle
		)
	}

	public func print(
		_ items: Any...,
		separator: String = " ",
		terminator: String = "\n",
		outputHandle: FileHandle = .standardOutput
	) {
		print(
			items,
			separator: separator,
			terminator: terminator,
			outputHandle: outputHandle
		)
	}
}
