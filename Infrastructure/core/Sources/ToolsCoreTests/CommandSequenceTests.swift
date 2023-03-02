//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import ToolsCore
import ToolsCoreTestKit
import XCTest

final class CommandSequenceTests: XCTestCase {
	private var commands = [CommandSequence.Command]()

	private lazy var sut = CommandSequence(
		errorHeader: "Header.",
		commands: commands,
		errorFooter: "Footer."
	)

	func test_Run_CommandsDoNotThrows_DoesNotThrowError() throws {
		commands = [
			{},
			{},
		]

		XCTAssertNoThrow(try sut.run())
	}

	func test_Run_CommandThrows_ThrowsError() throws {
		commands = [
			{},
			{ throw TestError(description: "Second error") },
			{ throw TestError(description: "Third error") },
		]

		XCTAssertThrowsError(try sut.run())
	}

	func test_Run_MultipleCommandsThrow_ThrowsErrorList() throws {
		commands = [
			{},
			{ throw TestError(description: "Second error") },
			{ throw TestError(description: "Third error") },
		]

		do {
			try sut.run()
			XCTFail("Expected error")
		} catch {
			if let errorList = error as? ErrorList {
				XCTAssertEqual(errorList.errors.count, 2)
			} else {
				XCTFail("Expected ErrorList, got: \(error.localizedErrorDescription)")
			}
		}
	}
}
