//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit

public final class CacheRepositoryMock: CacheRepository {
	public enum Input: Equatable {
		case currentCache(Project)
		case previousCache(ProjectPath)
		case save(cache: String, path: ProjectPath)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var computeCacheResult: Result<String, Error> = .failure(TestError(description: "mock"))
	public func computeCache(projectInfo: ProjectInfo) -> Result<String, Error> {
		inputs.append(.currentCache(projectInfo.project))
		return computeCacheResult
	}

	public var previousCacheResult: Result<String?, Error> = .failure(TestError(description: "mock"))
	public func fetchLastCache(cachePath: ProjectPath) -> Result<String?, Error> {
		inputs.append(.previousCache(cachePath))
		return previousCacheResult
	}

	public var saveResult: Result<Void, Error> = .failure(TestError(description: "mock"))
	public func save(_ cache: String, to cachePath: ProjectPath) -> Result<Void, Error> {
		inputs.append(.save(cache: cache, path: cachePath))
		return saveResult
	}
}
