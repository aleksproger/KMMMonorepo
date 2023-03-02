//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ProjectSpec

extension ProjectGraphBuilderKit {
	public struct ProjectInfo {
		public let project: Project
		public let projectDict: [String: Any]

		public init(
			project: Project,
			projectDict: [String: Any]
		) {
			self.project = project
			self.projectDict = projectDict
		}
	}
}

typealias ProjectInfo = ProjectGraphBuilderKit.ProjectInfo

extension ProjectInfo: Equatable, Hashable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.project == rhs.project
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(project)
	}
}

extension Project: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(name)
		hasher.combine(basePath)
	}
}
