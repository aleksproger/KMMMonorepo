//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ToolsCoreTestKit
import XCTest

final class CacheLoaderImplTest: XCTestCase {
	private lazy var sut = CacheLoaderImpl(
		fileManager: fileManager,
		makeString: { _ in
			self.makeStringWasCalled = true
			return "cache"
		}
	)

	private let fileManager = FileManagerTwinMock()

	private var makeStringWasCalled = false

	func test_LoadCache_CheckThatFileExists() {
		_ = sut.loadCache(from: "path")

		XCTAssertEqual(fileManager.inputs, [
			.fileExists(path: "path"),
		])
	}

	func test_LoadCache_FileNotExists_ReturnNil() throws {
		fileManager.isFileExist = false

		let result = try sut.loadCache(from: "path").get()

		XCTAssertEqual(result, nil)
	}

	func test_LoadCache_FileExists_MakesCacheString() throws {
		fileManager.isFileExist = true

		_ = try sut.loadCache(from: "path").get()

		XCTAssertTrue(makeStringWasCalled)
	}
}
