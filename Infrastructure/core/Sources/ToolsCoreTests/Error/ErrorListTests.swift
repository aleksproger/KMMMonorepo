//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ErrorListTests: XCTestCase {
	private var header: String?
	private var errors = [TestError]()
	private var footer: String?

	private lazy var sut = ErrorList(
		header: header,
		errors: errors,
		footer: footer
	)

	func test_Init_EmptyErrors_ReturnsNil() {
		errors = []

		XCTAssertNil(sut)
	}

	func test_ErrorDescription_ConcatenatesChildErrorDescriptions() throws {
		header = "Some header."
		errors = [
			TestError(description: "First."),
			TestError(description: "Second.\nWith extended length."),
			TestError(description: "Third."),
		]
		footer = "Some footer."

		guard let sut = sut else { return XCTFail("Expected sut") }

		XCTAssertEqual(
			sut.errorDescription,
			"""
			\u{1B}[1;33mSome header.\u{1B}[0m
			\u{1B}[1;33m1/3 error:\u{1B}[0m
			First.
			\u{1B}[1;33m2/3 error:\u{1B}[0m
			Second.
			With extended length.
			\u{1B}[1;33m3/3 error:\u{1B}[0m
			Third.
			\u{1B}[1;33mSome footer.\u{1B}[0m
			"""
		)
	}

	func test_ErrorDescription_SkipsHeaderAndFooter_IfNotSpecified() throws {
		header = nil
		errors = [
			TestError(description: "First."),
			TestError(description: "Second.\nWith extended length."),
			TestError(description: "Third."),
		]
		footer = nil

		guard let sut = sut else { return XCTFail("Expected sut") }

		XCTAssertEqual(
			sut.errorDescription,
			"""
			\u{1B}[1;33m1/3 error:\u{1B}[0m
			First.
			\u{1B}[1;33m2/3 error:\u{1B}[0m
			Second.
			With extended length.
			\u{1B}[1;33m3/3 error:\u{1B}[0m
			Third.\n
			"""
		)
	}
}
