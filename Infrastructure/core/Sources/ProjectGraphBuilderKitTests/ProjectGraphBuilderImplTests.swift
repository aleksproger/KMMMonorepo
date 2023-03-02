//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectGraphBuilderTestKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ProjectGraphBuilderImplTests: XCTestCase {
	private lazy var sut = ProjectGraphBuilderImpl(
		projectConfigBuilder: configBuilder
	)

	private let configBuilder = ProjectConfigBuilderMock()

	// MARK: - Single Root

	func test_BuildGraph_RootWithoutDependencies_ReturnExpectedGraph() throws {
		let one = config("one", [])
		configBuilder.configMap = ["one": one]

		let graph = try sut.buildGraph(rootProjects: [one]).get()

		XCTAssertEqual(graph, rootWithoutDependenciesGraph())
	}

	/// One --> None
	private func rootWithoutDependenciesGraph() -> AdjacencyList<ProjectConfig> {
		var expectedGraph = AdjacencyList<ProjectConfig>()
		_ = expectedGraph.makeNode(config("one", []))
		return expectedGraph
	}

	// MARK: - Root With One Dependency

	func test_BuildGraph_RootWithOneDependencyGraph_ReturnsExpectedGraph() throws {
		let one = config("one", ["two"])
		let two = config("two", [])
		configBuilder.configMap = ["one": one, "two": two]

		let graph = try sut.buildGraph(rootProjects: [one]).get()

		XCTAssertEqual(graph, try rootWithOneDependencyGraph())
	}

	/// Two --> One
	private func rootWithOneDependencyGraph() throws -> AdjacencyList<ProjectConfig> {
		var expectedGraph = AdjacencyList<ProjectConfig>()
		let one = expectedGraph.makeNode(config("one", ["two"]))
		let two = expectedGraph.makeNode(config("two", []))
		try expectedGraph.addEdge(from: two, to: one)
		return expectedGraph
	}

	// MARK: - Root With Two Dependencies

	func test_BuildGraph_RootWithTwoDependencies_ReturnsExpectedGraph() throws {
		let one = config("one", ["two", "three"])
		let two = config("two", [])
		let three = config("three", [])
		configBuilder.configMap = ["one": one, "two": two, "three": three]

		let graph = try sut.buildGraph(rootProjects: [one]).get()

		XCTAssertEqual(graph, try rootWithTwoDependenciesGraph())
	}

	/// Two ---->|
	///         One
	/// Three -->|
	private func rootWithTwoDependenciesGraph() throws -> AdjacencyList<ProjectConfig> {
		var expectedGraph = AdjacencyList<ProjectConfig>()
		let one = expectedGraph.makeNode(config("one", ["two", "three"]))
		let two = expectedGraph.makeNode(config("two", []))
		let three = expectedGraph.makeNode(config("three", []))
		try expectedGraph.addEdge(from: two, to: one)
		try expectedGraph.addEdge(from: three, to: one)
		return expectedGraph
	}

	// MARK: - Fully Connected Graph

	func test_BuildGraph_FullyConnectedGraph_ReturnsExpectedGraph() throws {
		let one = config("one", ["two", "three"])
		let two = config("two", ["three"])
		let three = config("three", [])
		configBuilder.configMap = ["one": one, "two": two, "three": three]

		let graph = try sut.buildGraph(rootProjects: [one]).get()

		XCTAssertEqual(graph, try fullyConnectedGraph())
	}

	/// Two ---->|
	///  /\      One
	/// Three -->|
	private func fullyConnectedGraph() throws -> AdjacencyList<ProjectConfig> {
		var expectedGraph = AdjacencyList<ProjectConfig>()
		let one = expectedGraph.makeNode(config("one", ["two", "three"]))
		let two = expectedGraph.makeNode(config("two", ["three"]))
		let three = expectedGraph.makeNode(config("three", []))
		try expectedGraph.addEdge(from: two, to: one)
		try expectedGraph.addEdge(from: three, to: one)
		try expectedGraph.addEdge(from: three, to: two)
		return expectedGraph
	}

	// MARK: - Direct Cycle Graph

	func test_BuildGraph_DirectCycleGraph_ReturnsExpectedGraph() throws {
		let one = config("one", ["two"])
		let two = config("two", ["one"])
		configBuilder.configMap = ["one": one, "two": two]

		let graph = try? sut.buildGraph(rootProjects: [one]).get()

		XCTAssertEqual(graph, try directCycleGraph())
	}

	/// Two <---> One
	private func directCycleGraph() throws -> AdjacencyList<ProjectConfig> {
		var expectedGraph = AdjacencyList<ProjectConfig>()
		let one = expectedGraph.makeNode(config("one", ["two"]))
		let two = expectedGraph.makeNode(config("two", ["one"]))
		try expectedGraph.addEdge(from: two, to: one)
		try expectedGraph.addEdge(from: one, to: two)
		return expectedGraph
	}

	private func config(_ name: String, _ dependencies: [String]) -> ProjectConfig {
		.fixture(projectInfo: .fixture(project:
			Project(
				name: name,
				projectReferences: dependencies.map { ProjectReference(name: $0, path: "\($0)Path") }
			)
		))
	}
}
