//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

protocol ProjectsOrderResolver {
	func resolve(for graph: AdjacencyList<ProjectConfig>) async -> Result<[ProjectConfig], Error>
}
