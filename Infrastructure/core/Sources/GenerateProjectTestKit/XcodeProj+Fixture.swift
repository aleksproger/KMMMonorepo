//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import XcodeProj

extension XcodeProj {
	public static func fixture(
		workspace: XCWorkspace = XCWorkspace(),
		pbxproj: PBXProj = PBXProj(),
		sharedData: XCSharedData? = nil
	) -> XcodeProj {
		XcodeProj(
			workspace: workspace,
			pbxproj: pbxproj,
			sharedData: sharedData
		)
	}
}
