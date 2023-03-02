//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
@testable import ProjectGraphBuilderKit
import ProjectGraphBuilderTestKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class CacheManagerImplTests: XCTestCase {
	private lazy var sut = CacheManagerImpl(
		cacheRepository: cacheRepository,
		xcodeProjValidator: xcodeProjValidator
	)

	private let cacheRepository = CacheRepositoryMock()
	private let fileManager = FileManagerTwinMock()
	private let xcodeProjValidator = XcodeProjValidatorMock()

	func test_ShouldUseCache_CachePathNil_ReturnsFalse() throws {
		let result = try sut.shouldUseCache(for: .fixture(cachePath: nil)).get()

		XCTAssertEqual(result, false)
	}

	func test_ShouldUseCache_ChecksWhetherXcodeProjValid() throws {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")
		cacheRepository.previousCacheResult = .success("cache")

		_ = try sut.shouldUseCache(for: .fixture(cachePath: Env.cachePath)).get()

		XCTAssertEqual(xcodeProjValidator.inputs, [
			.isValid(Env.projectInfo.project.defaultProjectPath),
		])
	}

	func test_ShouldUseCache_XcodeProjDoesNotExistOrInvalid_ReturnsFalse() throws {
		let result = try sut.shouldUseCache(for: .fixture(cachePath: Env.cachePath)).get()

		XCTAssertEqual(result, false)
	}

	func test_ShouldUseCache_CachesEqual_ReturnsTrue() throws {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")
		cacheRepository.previousCacheResult = .success("cache")

		let result = try sut.shouldUseCache(for: Env.config).get()

		XCTAssertEqual(result, true)
	}

	func test_ShouldUseCache_CachesEqual_DoesNotSaveNewCache() {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")
		cacheRepository.previousCacheResult = .success("cache")

		_ = sut.shouldUseCache(for: Env.config)

		XCTAssertEqual(cacheRepository.inputs, [
			.currentCache(Env.projectInfo.project),
			.previousCache(Env.cachePath),
		])
	}

	func test_ShouldUseCache_CachesAreDifferent_ReturnsFalse() throws {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")
		cacheRepository.previousCacheResult = .success("other_cache")

		let result = try sut.shouldUseCache(for: Env.config).get()

		XCTAssertEqual(result, false)
	}

	func test_ShouldUseCache_CachesAreDifferent_SavesNewCache() {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")
		cacheRepository.previousCacheResult = .success("other_cache")

		_ = sut.shouldUseCache(for: Env.config)

		XCTAssertEqual(cacheRepository.inputs, [
			.currentCache(Env.projectInfo.project),
			.previousCache(Env.cachePath),
		])
	}

	func test_SaveCacheIfNeeded_CachePathNil_DoesNotSave_ReturnsSuccess() {
		xcodeProjValidator.isValidResult = .success(true)
		let result = sut.saveCacheIfNeeded(for: .fixture(cachePath: nil))

		XCTAssertNoThrow(try result.get())
	}

	func test_SaveCacheIfNeeded_CachePathNotNil_ComputesAndSavesCache() {
		xcodeProjValidator.isValidResult = .success(true)
		cacheRepository.computeCacheResult = .success("cache")

		_ = sut.saveCacheIfNeeded(for: .fixture(cachePath: Env.cachePath))

		XCTAssertEqual(cacheRepository.inputs, [
			.currentCache(Env.projectInfo.project),
			.save(cache: "cache", path: Env.cachePath),
		])
	}
}

private enum Env {
	static let projectInfo = ProjectInfo(project: Project(name: "test"), projectDict: [:])
	static let config = ProjectConfig.fixture(cachePath: cachePath)
	static let cachePath: ProjectPath = .absolute("testPath")
}
