//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

final class ProjectsOrderResolverImpl: ProjectsOrderResolver {
	private let dfsFactory: MarkingDFSFactory

	init(
		dfsFactory: MarkingDFSFactory
	) {
		self.dfsFactory = dfsFactory
	}

	func resolve(for graph: AdjacencyList<ProjectConfig>) async -> Result<[ProjectConfig], Error> {
		do {
			let dfs = try await dfsFactory.make(nodes: Array(graph.adjacencyList.keys))
			let allProjectsOrder = try graph.topologicallySorted(using: dfs).get()
			let projectsNeedingRegeneration: [ProjectConfig] = allProjectsOrder.compactMap { node in
				guard dfs.markedNodes.contains(node) else {
					return nil
				}
				return node.value
			}
			return .success(projectsNeedingRegeneration)
		} catch {
			return .failure(error)
		}
	}
}
