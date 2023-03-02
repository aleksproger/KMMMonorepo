//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ProjectSpec
import ToolsCoreTestKit

public final class CacheLoaderMock: CacheLoader {
	public enum Input: Equatable {
		case loadCache(path: String)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public private(set) var loadCacheResult: Result<String?, Error> = .failure(TestError(description: "mock"))
	public func loadCache(from path: String) -> Result<String?, Error> {
		inputs.append(.loadCache(path: path))
		return loadCacheResult
	}
}
