//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

final class ProjectGraphBuilderImpl: ProjectGraphBuilder {
	private let projectConfigBuilder: ProjectConfigBuilder

	init(projectConfigBuilder: ProjectConfigBuilder) {
		self.projectConfigBuilder = projectConfigBuilder
	}

	func buildGraph(rootProjects: [ProjectConfig]) -> Result<AdjacencyList<ProjectConfig>, Error> {
		do {
			var graph = AdjacencyList<ProjectConfig>()
			for projectConfig in rootProjects {
				try bfs(config: projectConfig, graph: &graph)
			}
			return .success(graph)
		} catch {
			return .failure(error)
		}
	}

	private func bfs(
		config: ProjectConfig,
		graph: inout AdjacencyList<ProjectConfig>
	) throws {
		var projectsQueue = Queue<Node<ProjectConfig>>()
		var visited = Set<ProjectConfig>()

		let rootNode = graph.makeNode(config)
		projectsQueue.enqueue(rootNode)

		while let dependencyNode = projectsQueue.dequeue() {
			if visited.contains(dependencyNode.value) { continue }
			visited.insert(dependencyNode.value)

			let childConfigs = getChildNodes(for: dependencyNode.value)

			try childConfigs.forEach { config in
				let newNode = try add(config, to: dependencyNode, in: &graph)
				print("Add node: \(config.projectInfo.project.name) to \(dependencyNode.value.projectInfo.project.name)")
				projectsQueue.enqueue(newNode)
			}
		}
	}

	private func getChildNodes(for config: ProjectConfig) -> [ProjectConfig] {
		config.projectInfo.project.projectReferences.compactMap { reference in
			projectConfigBuilder.config(reference.name)
		}
	}

	private func add(
		_ config: ProjectConfig,
		to dependencyNode: Node<ProjectConfig>,
		in graph: inout AdjacencyList<ProjectConfig>
	) throws -> Node<ProjectConfig> {
		let newNode = graph.makeNode(config)
		try graph.addEdge(from: newNode, to: dependencyNode)
		return newNode
	}
}
