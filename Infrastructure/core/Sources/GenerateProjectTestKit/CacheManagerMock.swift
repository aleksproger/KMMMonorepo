//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ProjectSpec
import ToolsCoreTestKit

public final class CacheManagerMock: CacheManager {
	public enum Input: Equatable {
		case shouldUseCache(ProjectConfig)
		case saveCacheIfNeeded(ProjectConfig)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var shouldUseCacheResult: Result<Bool, Error> = .failure(TestError(description: "mock"))
	public func shouldUseCache(
		for config: ProjectConfig
	) -> Result<Bool, Error> {
		inputs.append(.shouldUseCache(config))
		return shouldUseCacheResult
	}

	public var saveCacheIfNeededResult: Result<Void, Error> = .failure(TestError())
	public func saveCacheIfNeeded(
		for config: ProjectConfig
	) -> Result<Void, Error> {
		inputs.append(.saveCacheIfNeeded(config))
		return saveCacheIfNeededResult
	}
}
