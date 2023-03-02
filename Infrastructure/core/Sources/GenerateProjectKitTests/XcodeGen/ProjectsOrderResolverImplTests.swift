//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class ProjectsOrderResolverImplTests: XCTestCase {
	private lazy var sut = ProjectsOrderResolverImpl(
		dfsFactory: dfsFactory
	)

	private let dfsFactory = MarkingDFSFactoryMock()

	func test_Resolve_AllNodesAreMarked_ReturnsAllNodesInRightOrder() async throws {
		dfsFactory.makeResult = Env.dfsWithAllNodesMarked

		let order = try await sut.resolve(for: try .treeShapedGraphFixture()).get()

		XCTAssertEqual(order, [
			.fixture(projectInfo: .fixture(project: Project(name: "3"))),
			.fixture(projectInfo: .fixture(project: Project(name: "2"))),
			.fixture(projectInfo: .fixture(project: Project(name: "1"))),
		])
	}

	func test_Resolve_ThirdNodeNotMarked_ReturnsOnlyMarkedNodePreservingOrder() async throws {
		dfsFactory.makeResult = Env.dfsWithThirdNodeUnmarked

		let order = try await sut.resolve(for: try .treeShapedGraphFixture()).get()

		XCTAssertEqual(order, [
			.fixture(projectInfo: .fixture(project: Project(name: "2"))),
			.fixture(projectInfo: .fixture(project: Project(name: "1"))),
		])
	}
}

private enum Env {
	static let dfsWithAllNodesMarked = ThreeColoredDFSWithMarkers<ProjectConfig>(
		markableNodes: Set([
			Node(.fixture(projectInfo: .fixture(project: Project(name: "1")))),
			Node(.fixture(projectInfo: .fixture(project: Project(name: "2")))),
			Node(.fixture(projectInfo: .fixture(project: Project(name: "3")))),
		])
	)

	static let dfsWithThirdNodeUnmarked = ThreeColoredDFSWithMarkers<ProjectConfig>(
		markableNodes: Set([
			Node(.fixture(projectInfo: .fixture(project: Project(name: "1")))),
			Node(.fixture(projectInfo: .fixture(project: Project(name: "2")))),
		])
	)
}
