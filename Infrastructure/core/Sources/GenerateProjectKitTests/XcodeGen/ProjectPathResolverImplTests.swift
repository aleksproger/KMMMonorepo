//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ProjectPathResolverImplTests: XCTestCase {
	func test_Resolve_RelativePath_GitTopLevelSuccess_ReturnFullPath() {
		let sut = ProjectPathResolverImpl(basePath: "topLevel")

		let path = try? sut.resolve(path: .rootRelative("path")).get()
		guard let path = path else {
			return XCTFail("Unexpected failure in path resolve result.")
		}

		XCTAssertEqual(path, "topLevel/path")
	}

	func test_Resolve_PathWithCyrillicSymbols_ReturnFullPath() {
		let sut = ProjectPathResolverImpl(basePath: "директория")

		let path = try? sut.resolve(path: .rootRelative("path")).get()
		guard let path = path else {
			return XCTFail("Unexpected failure in path resolve result.")
		}

		XCTAssertEqual(path, "директория/path")
	}
}
