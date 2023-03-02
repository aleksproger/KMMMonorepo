//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ProjectSpec
import XcodeProj

public struct GeneratedProjectInfo: Equatable {
	public let xcodeProject: XcodeProj
	public let specProject: Project

	public init(
		xcodeProject: XcodeProj,
		specProject: Project
	) {
		self.xcodeProject = xcodeProject
		self.specProject = specProject
	}
}
