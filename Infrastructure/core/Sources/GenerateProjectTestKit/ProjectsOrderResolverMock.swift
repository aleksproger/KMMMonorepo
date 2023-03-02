//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ToolsCore
import ToolsCoreTestKit

public final class ProjectsOrderResolverMock: ProjectsOrderResolver {
	public enum Input: Equatable {
		case resolve(AdjacencyList<ProjectConfig>)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var resolveResult: Result<[ProjectConfig], Error> = .failure(TestError())
	public func resolve(for graph: AdjacencyList<ProjectConfig>) -> Result<[ProjectConfig], Error> {
		inputs.append(.resolve(graph))
		return resolveResult
	}
}
