//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ToolsCore
import XCTest

final class SwiftVersionTests: XCTestCase {
	func test_SwiftVersion_ReturnsExpected() {
		XCTAssertEqual(Tools.swiftVersion, "5.1")
	}
}
