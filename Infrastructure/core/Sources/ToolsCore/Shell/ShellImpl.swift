//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public class ShellImpl: Shell {
	private let stdErr = FileHandle.standardError
	private let stdOut = FileHandle.standardOutput

	public init() {}

	@discardableResult
	public func bash(
		to command: String,
		arguments: [String],
		at path: String,
		outputHandle: FileHandle? = nil,
		errorHandle: FileHandle? = nil
	) throws -> String {
		let command = "cd \(path.escapingSpaces) && \(command) \(arguments.joined(separator: " "))"

		return try Process().launchBash(
			with: command,
			outputHandle: outputHandle,
			errorHandle: errorHandle
		)
	}

	public func print(
		_ items: [Any],
		separator: String,
		terminator: String,
		outputHandle: FileHandle
	) {
		var iterator = items
			.lazy
			.map(String.init(describing:))
			.makeIterator()
		iterator
			.next()
			.map { outputHandle.write($0) }
		while let item = iterator.next() {
			outputHandle.write(separator)
			outputHandle.write(item)
		}
		outputHandle.write(terminator)
	}
}

extension FileHandle {
	func write(_ string: String, encoding: String.Encoding = .utf8) {
		#if !(os(macOS) || os(tvOS))
		guard !string.isEmpty else { return }
		#endif
		guard let data = string.data(using: encoding, allowLossyConversion: false) else {
			fatalError("Could not convert text to binary data.")
		}
		self.write(data)
	}
}

public struct BashError: Error, CustomStringConvertible, LocalizedError {
	public let command: String
	public let terminationStatus: Int32
	public var message: String { errorData.makeShellOutput() }
	public let errorData: Data
	public let outputData: Data
	public var output: String { outputData.makeShellOutput() }

	public var description: String {
		"""
		During command: "\(command)"
		Shell encountered an error
		Status code: \(terminationStatus)
		Message:
		\(message)
		Output:
		\(output)
		"""
	}

	public var errorDescription: String? {
		description
	}
}

extension Process {
	@discardableResult
	// swiftlint:disable:next function_body_length
	fileprivate func launchBash(
		with command: String,
		outputHandle: FileHandle? = nil,
		errorHandle: FileHandle? = nil,
		verbose _: Bool = false
	) throws -> String {
		launchPath = "/bin/bash"
		arguments = ["-c", command]

		// Because FileHandle's readabilityHandler might be called from a
		// different queue from the calling queue, avoid a data race by
		// protecting reads and writes to outputData and errorData on
		// a single dispatch queue.
		let outputQueue = DispatchQueue(label: "ru.sberbank.sberdevices.tools.bash")

		var outputData = Data()
		var errorData = Data()

		let outputPipe = Pipe()
		standardOutput = outputPipe

		let errorPipe = Pipe()
		standardError = errorPipe

		outputPipe.fileHandleForReading.readabilityHandler = { handler in
			let data = handler.availableData
			outputQueue.async {
				outputData.append(data)
				outputHandle?.write(data)
			}
		}

		errorPipe.fileHandleForReading.readabilityHandler = { handler in
			let data = handler.availableData
			outputQueue.async {
				errorData.append(data)
				errorHandle?.write(data)
			}
		}

		if toolsEnv.verbose {
			var path = [launchPath]
			if let arguments = self.arguments {
				path.append(contentsOf: arguments)
			}
			let fullCommand = path
				.compactMap { $0 }
				.joined(separator: " ")
			printDebug("Executing command: \(fullCommand)")
		}

		launch()

		waitUntilExit()
		if let handle = outputHandle, !handle.isStandard {
			handle.closeFile()
		}

		if toolsEnv.verbose {
			printDebug("Output:\n\(String(data: outputData, encoding: .utf8)!)")
			printDebug("Error:\n\(String(data: errorData, encoding: .utf8)!)")
		}
		if let handle = errorHandle, !handle.isStandard {
			handle.closeFile()
		}

		outputPipe.fileHandleForReading.readabilityHandler = nil
		errorPipe.fileHandleForReading.readabilityHandler = nil

		// Block until all writes have occurred to outputData and errorData,
		// and then read the data back out.
		return try outputQueue.sync {
			guard terminationStatus == 0 else {
				throw BashError(
					command: command,
					terminationStatus: terminationStatus,
					errorData: errorData,
					outputData: outputData
				)
			}

			return outputData.makeShellOutput()
		}
	}

	private func printDebug(_ message: String) {
		print("[DEBUG] \(message)")
	}
}

extension FileHandle {
	fileprivate var isStandard: Bool {
		self === Self.standardOutput
			|| self === Self.standardError
			|| self === Self.standardInput
	}
}

extension Data {
	fileprivate func makeShellOutput() -> String {
		guard let output = String(data: self, encoding: .utf8) else {
			return ""
		}

		guard !output.hasSuffix("\n") else {
			let endIndex = output.index(before: output.endIndex)
			return String(output[..<endIndex])
		}

		return output
	}
}

extension String {
	fileprivate var escapingSpaces: String {
		replacingOccurrences(of: " ", with: "\\ ")
	}
}
