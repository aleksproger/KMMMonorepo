//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ToolsCoreTestKit

public final class CacheWriterMock: CacheWriter {
	public enum Input: Equatable {
		case write(cache: String, path: String)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var writeResult: Result<Void, Error> = .failure(TestError(description: "mock"))

	public func write(cache: String, to path: String) throws {
		inputs.append(.write(cache: cache, path: path))
		try writeResult.get()
	}
}
