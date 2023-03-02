//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import ToolsCore
import XCTest

final class ShellImplTests: XCTestCase {
	private lazy var sut = ShellImpl()

	func test_Bash_WhenThereAreNotArguments() throws {
		let output = try sut.bash(to: "uptime")

		XCTAssertTrue(output.contains("load averages"))
	}

	func test_Bash_WhenThereAreArguments() throws {
		let output = try sut.bash(to: "echo", arguments: ["Hi"])

		XCTAssertEqual(output, "Hi")
	}

	func test_Bash_WhenArgumentsAreInlinable() throws {
		let output = try sut.bash(to: "echo \"Hello world\"")

		XCTAssertEqual(output, "Hello world")
	}

	func test_Bash_WhenExecuteCommandWithPath() throws {
		try sut.bash(to: "echo \"Hello\" > \(NSTemporaryDirectory())ShellTests-SingleCommand.txt")

		let textFileContent = try sut.bash(
			to: "cat ShellTests-SingleCommand.txt",
			at: NSTemporaryDirectory()
		)

		XCTAssertEqual(textFileContent, "Hello")
	}

	func test_Bash_WhenExecuteCommandWithPath_AndItContainsSpaces() throws {
		try sut.bash(to: "mkdir -p \"Shell Test Folder\"", at: NSTemporaryDirectory())
		try sut.bash(to: "echo \"Hello\" > File", at: NSTemporaryDirectory() + "Shell Test Folder")

		let output = try sut.bash(to: "cat \(NSTemporaryDirectory())Shell\\ Test\\ Folder/File")
		XCTAssertEqual(output, "Hello")
	}

	func test_Bash_WhenExecuteCommandWithPath_AndItContainsTilde() throws {
		let homeContents = try sut.bash(to: "ls", at: "~")
		XCTAssertFalse(homeContents.isEmpty)
	}

	func test_Bash_WhenExecuteManyCommandAtTime() throws {
		let echo = try sut.bash(to: ["echo \"Hello\"", "echo \"world\""])
		XCTAssertEqual(echo, "Hello\nworld")
	}

	func test_Bash_WhenExecuteManyCommandAtTime_AndItContainsPath() throws {
		try sut.bash(to: [
			"cd \(NSTemporaryDirectory())",
			"mkdir -p ShellTests",
			"echo \"Hello again\" > ShellTests/MultipleCommands.txt",
		])

		let textFileContent = try sut.bash(to: [
			"cd ShellTests",
			"cat MultipleCommands.txt",
		], at: NSTemporaryDirectory())

		XCTAssertEqual(textFileContent, "Hello again")
	}

	func test_Bash_WhenCommandThrowsError() {
		do {
			try sut.bash(to: "cd", arguments: ["notADirectory"])
			XCTFail("Expected expression to throw")
		} catch let error as BashError {
			XCTAssertTrue(error.message.contains("notADirectory"))
			XCTAssertTrue(error.output.isEmpty)
			XCTAssertTrue(error.terminationStatus != 0)
		} catch {
			XCTFail("Invalid error type: \(error)")
		}
	}

	func test_Bash_WhenCommandThrowsError_AndItContainsDescription() {
		let errorMessage = "Hey, I'm an error!"
		let output = "Some output"

		let error = BashError(
			command: "git clone",
			terminationStatus: 7,
			errorData: errorMessage.data(using: .utf8)!,
			outputData: output.data(using: .utf8)!
		)

		let expectedErrorDescription = """
		During command: "git clone"
		Shell encountered an error
		Status code: 7
		Message:
		Hey, I'm an error!
		Output:
		Some output
		"""

		XCTAssertEqual("\(error)", expectedErrorDescription)
		XCTAssertEqual(error.localizedDescription, expectedErrorDescription)
	}

	func test_Bash_WhenExecuteCommand_CapturesOutputWithHandler() throws {
		let pipe = Pipe()
		let output = try sut.bash(to: "echo", arguments: ["Hello"], outputHandle: pipe.fileHandleForWriting)
		let capturedData = pipe.fileHandleForReading.readDataToEndOfFile()
		XCTAssertEqual(output, "Hello")
		XCTAssertEqual(output + "\n", String(data: capturedData, encoding: .utf8))
	}

	func test_Bash_WhenExecuteCommand_AndItThrowsError_CapturesErrorOutputWithHandler() {
		let pipe = Pipe()

		do {
			_ = try sut.bash(to: "cd", arguments: ["notADirectory"], errorHandle: pipe.fileHandleForWriting)
			XCTFail("Expected expression to throw")
		} catch let error as BashError {
			XCTAssertTrue(error.message.contains("notADirectory"))
			XCTAssertTrue(error.output.isEmpty)
			XCTAssertTrue(error.terminationStatus != 0)

			let capturedData = pipe.fileHandleForReading.readDataToEndOfFile()
			XCTAssertEqual(error.message + "\n", String(data: capturedData, encoding: .utf8))
		} catch {
			XCTFail("Invalid error type: \(error)")
		}
	}

	func test_Print_PrintsStringInTheFormat() throws {
		let pipe = Pipe()

		sut.print("Any", outputHandle: pipe.fileHandleForWriting)

		pipe.fileHandleForWriting.closeFile()
		let capturedData = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: capturedData, encoding: .utf8)
		XCTAssertEqual(output, "Any\n")
	}
}
