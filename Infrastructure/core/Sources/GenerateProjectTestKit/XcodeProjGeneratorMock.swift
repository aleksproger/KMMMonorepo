//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import ToolsCore
import ToolsCoreTestKit
import XcodeProj

public final class XcodeProjGeneratorMock: XcodeProjGenerator {
	public enum Input: Equatable {
		case generateXcodeProj(
			ProjectInfo,
			ProjectPath
		)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var generateResult: Result<XcodeProj, Error> = .failure(TestError(description: "mock"))
	@discardableResult
	public func generateXcodeProj(
		_ projectInfo: ProjectInfo,
		in projectPath: ProjectPath
	) -> Result<XcodeProj, Error> {
		inputs.append(.generateXcodeProj(projectInfo, projectPath))
		return generateResult
	}
}
