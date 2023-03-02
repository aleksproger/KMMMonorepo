//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import GenerateProjectKit
import ProjectSpec
import XcodeProj

extension GeneratedProjectInfo {
	public static func fixture(
		xcodeProject: XcodeProj = .fixture(),
		specProject: Project = Project(name: "fixture")
	) -> GeneratedProjectInfo {
		GeneratedProjectInfo(
			xcodeProject: xcodeProject,
			specProject: specProject
		)
	}
}
