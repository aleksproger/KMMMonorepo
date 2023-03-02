//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectSpec

extension ProjectInfo {
	public static func fixture(
		project: Project = Project(name: "test"),
		projectDict: [String: Any] = [:]
	) -> ProjectInfo {
		ProjectInfo(
			project: project,
			projectDict: projectDict
		)
	}
}
