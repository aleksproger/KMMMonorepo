//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import ToolsCore

public protocol ProjectGraphBuilder {
	func buildGraph(
		rootProjects: [ProjectGraphBuilderKit.ProjectConfig]
	) -> Result<AdjacencyList<ProjectGraphBuilderKit.ProjectConfig>, Error>
}
