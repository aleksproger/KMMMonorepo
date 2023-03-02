//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ProjectSpec
import ToolsCore

public protocol ProjectSpecLoader {
	func loadSpec(at path: ProjectPath) -> Result<ProjectGraphBuilderKit.ProjectInfo, Error>
}
