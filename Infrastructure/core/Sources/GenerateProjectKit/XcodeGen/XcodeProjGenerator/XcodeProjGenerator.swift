//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore
import XcodeProj

protocol XcodeProjGenerator {
	@discardableResult
	func generateXcodeProj(
		_ projectInfo: ProjectInfo,
		in projectPath: ProjectPath
	) -> Result<XcodeProj, Error>
}
