//
//  Copyright © 2020 Sberbank. All rights reserved.
//

@testable import FormatterKit
import XCTest

final class SwiftFormatterTest: XCTestCase {
	func test_Init_ConfigIsEqualToSwiftFormatConfig() {
		let sut = SwiftFormater()

		XCTAssertEqual(
			sut.configPath,
			".swiftformat.config"
		)
	}
}
