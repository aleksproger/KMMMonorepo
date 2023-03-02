//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ToolsCoreTestKit
import XCTest

final class CacheWriterImplTests: XCTestCase {
	private lazy var sut = CacheWriterImpl(
		fileManager: fileManager,
		writeCache: { _, _ in self.writeCacheWasCalled = true }
	)

	private let fileManager = FileManagerTwinMock()

	private var writeCacheWasCalled = false

	func test_WriteCache_PathNotExist_CreatesDirectory() throws {
		fileManager.isFileExist = false
		fileManager.createDirectoryResult = .success(())

		try sut.write(cache: "cache", to: "some/path")

		XCTAssertTrue(writeCacheWasCalled)
		XCTAssertEqual(fileManager.inputs, [
			.fileExists(path: "some/path"),
			.createDirectory(path: "some", withIntermediates: true),
		])
	}

	func test_WriteCache_PathExist_DoesNotCreateDirectory() throws {
		fileManager.isFileExist = true

		try sut.write(cache: "cache", to: "some/path")

		XCTAssertTrue(writeCacheWasCalled)
		XCTAssertEqual(fileManager.inputs, [
			.fileExists(path: "some/path"),
		])
	}
}
