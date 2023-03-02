//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

extension ProjectGraphBuilderKit {
	public struct ProjectConfig: Hashable {
		public let projectInfo: ProjectInfo
		public let directoryPath: ProjectPath
		public let cachePath: ProjectPath?
		public let quiet: Bool

		public init(
			projectInfo: ProjectInfo,
			directoryPath: ProjectPath,
			cachePath: ProjectPath?,
			quiet: Bool
		) {
			self.projectInfo = projectInfo
			self.directoryPath = directoryPath
			self.cachePath = cachePath
			self.quiet = quiet
		}
	}
}

typealias ProjectConfig = ProjectGraphBuilderKit.ProjectConfig
