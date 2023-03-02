//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

protocol WorkspaceGenerator {
	@discardableResult
	func generate(from graph: AdjacencyList<ProjectConfig>) async throws -> [GeneratedProjectInfo]
}
