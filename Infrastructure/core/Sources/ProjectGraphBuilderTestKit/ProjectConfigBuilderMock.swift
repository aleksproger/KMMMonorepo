//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ToolsCoreTestKit

public final class ProjectConfigBuilderMock: ProjectConfigBuilder {
	public enum Input: Equatable {
		case config(String)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var configMap = [String: ProjectConfig?]()
	public func config(_ projectName: String) -> ProjectConfig? {
		inputs.append(.config(projectName))
		return configMap[projectName]!
	}
}
