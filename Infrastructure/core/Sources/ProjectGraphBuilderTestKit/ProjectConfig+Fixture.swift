//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ToolsCore

extension ProjectConfig {
	public static func fixture(
		projectInfo: ProjectInfo = .fixture(),
		directoryPath: ProjectPath = .rootRelative("projectPath"),
		cachePath: ProjectPath? = nil,
		quiet: Bool = false
	) -> ProjectConfig {
		ProjectConfig(
			projectInfo: projectInfo,
			directoryPath: directoryPath,
			cachePath: cachePath,
			quiet: quiet
		)
	}
}
