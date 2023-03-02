//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ToolsCore

public final class ProjectPathResolverMock: ProjectPathResolver {
	public enum Input: Equatable {
		case resolve(ProjectPath)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var resolveResult: Result<String, Error> = .failure(TestError(description: "mock"))
	public func resolve(path: ProjectPath) -> Result<String, Error> {
		inputs.append(.resolve(path))
		return resolveResult
	}
}
