//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
@testable import GenerateProjectKit
import ToolsCore
import ToolsCoreTestKit

public final class ProjectGeneratorMock: ProjectGenerator {
	public enum Input: Hashable {
		case generateProject(ProjectConfig)
	}

	public var inputs = AtomicArray<Input>()

	public init() {}

	public var generateProjectResult: Result<GeneratedProjectInfo, Error> = .failure(TestError())

	public func generateProject(using config: ProjectConfig) throws -> GeneratedProjectInfo {
		inputs.append(.generateProject(config))
		return try generateProjectResult.get()
	}
}
