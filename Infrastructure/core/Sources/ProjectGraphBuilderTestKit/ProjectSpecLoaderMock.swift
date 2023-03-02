//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit

public final class ProjectSpecLoaderMock: ProjectSpecLoader {
	public enum Input: Equatable {
		case loadSpec(path: ProjectPath)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var loadResult: Result<ProjectInfo, Error> = .failure(TestError(description: "mock"))
	public func loadSpec(at path: ProjectPath) -> Result<ProjectInfo, Error> {
		inputs.append(.loadSpec(path: path))
		return loadResult
	}
}
