//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectSpec
import ToolsCore

extension AdjacencyList where T == ProjectConfig {
	public static func treeShapedGraphFixture(
		firstProject: ProjectConfig = .fixture(projectInfo: .fixture(project: Project(name: "1"))),
		secondProject: ProjectConfig = .fixture(projectInfo: .fixture(project: Project(name: "2"))),
		thirdProject: ProjectConfig = .fixture(projectInfo: .fixture(project: Project(name: "3")))
	) throws -> AdjacencyList<T> {
		var graph = AdjacencyList<ProjectConfig>()
		let one = graph.makeNode(firstProject)
		let two = graph.makeNode(secondProject)
		let three = graph.makeNode(thirdProject)
		try graph.addEdge(from: two, to: one)
		try graph.addEdge(from: three, to: one)
		try graph.addEdge(from: three, to: two)
		return graph
	}
}
