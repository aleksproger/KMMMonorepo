//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ToolsCoreTestKit
import XCTest

final class CacheRepositoryImplTests: XCTestCase {
	private lazy var sut = CacheRepositoryImpl(
		pathResolver: pathResolver,
		cacheWriter: cacheWriter,
		cacheLoader: cacheLoader
	)

	private let pathResolver = ProjectPathResolverMock()
	private let cacheWriter = CacheWriterMock()
	private let cacheLoader = CacheLoaderMock()

	func test_FetchLastCache_ResolvesPath() {
		_ = sut.fetchLastCache(cachePath: .absolute("testPath"))

		XCTAssertEqual(pathResolver.inputs, [.resolve(.absolute("testPath"))])
	}

	func test_FetchLastCache_LoadsCache() {
		pathResolver.resolveResult = .success("testPath")

		_ = sut.fetchLastCache(cachePath: .absolute("testPath"))

		XCTAssertEqual(cacheLoader.inputs, [.loadCache(path: "testPath")])
	}

	func test_Save_ResolvesPath() {
		_ = sut.save("cache", to: .absolute("testPath"))

		XCTAssertEqual(pathResolver.inputs, [.resolve(.absolute("testPath"))])
	}

	func test_Save_WritesCache() {
		pathResolver.resolveResult = .success("testPath")

		_ = sut.save("cache", to: .absolute("testPath"))

		XCTAssertEqual(cacheWriter.inputs, [
			.write(cache: "cache", path: "testPath"),
		])
	}
}
