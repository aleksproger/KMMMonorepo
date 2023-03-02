//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

actor WorkspaceGeneratorImpl: WorkspaceGenerator {
	private let projectGenerator: ProjectGenerator
	private let orderResolver: ProjectsOrderResolver
	private let cacheManager: CacheManager
	private let mode: XcodeGenMode

	private var generated = [GeneratedProjectInfo]()
	private var tasks = [ProjectConfig: Task<Void, Error>]()

	init(
		projectGenerator: ProjectGenerator,
		orderResolver: ProjectsOrderResolver,
		cacheManager: CacheManager,
		mode: XcodeGenMode
	) {
		self.projectGenerator = projectGenerator
		self.orderResolver = orderResolver
		self.cacheManager = cacheManager
		self.mode = mode
	}

	@discardableResult
	func generate(from graph: AdjacencyList<ProjectConfig>) async throws -> [GeneratedProjectInfo] {
		switch mode {
		case .stable:
			return try await generateInSequence(from: graph)
		case .fast:
			return try await generateInParallel(from: graph)
		}
	}

	@discardableResult
	func generateInSequence(from graph: AdjacencyList<ProjectConfig>) async throws -> [GeneratedProjectInfo] {
		let projectsOrder = try await orderResolver.resolve(for: graph).get()
		print("Start generating graph in order: \(projectsOrder.map(\.projectInfo.project.name))")
		return try await projectsOrder.asyncMap { projectConfig in
			defer { cacheManager.saveCacheIfNeeded(for: projectConfig) }
			return try projectGenerator.generateProject(using: projectConfig)
		}
	}

	@discardableResult
	func generateInParallel(from graph: AdjacencyList<ProjectConfig>) async throws -> [GeneratedProjectInfo] {
		let projectsOrder = try await orderResolver.resolve(for: graph).get()
		print("Start generating graph in order: \(projectsOrder.map(\.projectInfo.project.name))")

		tasks.removeAll()
		generated.removeAll()

		for project in projectsOrder {
			let task = Task { [weak self] in
				guard let self = self else {
					return
				}
				let dependencies = graph.dependencies(for: project)
				let tasks = await self.tasks
				let dependenciesTasks = dependencies.compactMap { tasks[$0] }

				for task in dependenciesTasks {
					try await task.value
				}

				defer { self.cacheManager.saveCacheIfNeeded(for: project) }
				let generatedProject = try self.projectGenerator.generateProject(using: project)
				await self.projectGenerated(generatedProject)
			}

			tasks[project] = task
		}

		for task in tasks.values {
			try await task.value
		}

		return generated
	}

	private func projectGenerated(_ project: GeneratedProjectInfo) {
		generated.append(project)
	}
}

extension AdjacencyList where T == ProjectConfig {
	func dependencies(for project: ProjectConfig) -> [ProjectConfig] {
		let projectNode = Node(project)
		var result = [ProjectConfig]()
		for (fromNode, toNodes) in adjacencyList {
			if toNodes.contains(projectNode) {
				result.append(fromNode.value)
				continue
			}
		}

		return result
	}
}
