//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import GenerateProjectKit
import GenerateProjectTestKit
import ProjectGraphBuilderTestKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit
import XCTest

final class WorkspaceGeneratorImplUnitTests: XCTestCase {
	private var mode: XcodeGenMode = .stable
	private lazy var sut = WorkspaceGeneratorImpl(
		projectGenerator: projectGenerator,
		orderResolver: orderResolver,
		cacheManager: cacheManager,
		mode: mode
	)

	private let projectGenerator = ProjectGeneratorMock()
	private let orderResolver = ProjectsOrderResolverMock()
	private let cacheManager = CacheManagerMock()

	private let graph = AdjacencyList<ProjectConfig>()

	func test_Generate_AsksOrderResolver_ForProjectOrder() async throws {
		orderResolver.resolveResult = .success([])

		try await sut.generate(from: graph)

		XCTAssertEqual(orderResolver.inputs, [.resolve(graph)])
	}

	func test_GenerateInmode_GenerateProject_ForEachProvidedConfig() async throws {
		mode = .fast

		orderResolver.resolveResult = .success([
			.fixture(projectInfo: .fixture(project: Project(name: "1"))),
			.fixture(projectInfo: .fixture(project: Project(name: "2"))),
		])
		projectGenerator.generateProjectResult = .success(.fixture())
		cacheManager.saveCacheIfNeededResult = .success(())

		try await sut.generate(from: graph)

		let inputs = Set(projectGenerator.inputs.value)
		XCTAssertEqual(inputs, Set([
			.generateProject(.fixture(projectInfo: .fixture(project: Project(name: "1")))),
			.generateProject(.fixture(projectInfo: .fixture(project: Project(name: "2")))),
		]))
	}

	func test_Generate_GenerateProjectSequentially_ForEachProvidedConfig() async throws {
		orderResolver.resolveResult = .success([
			.fixture(projectInfo: .fixture(project: Project(name: "1"))),
			.fixture(projectInfo: .fixture(project: Project(name: "2"))),
		])
		projectGenerator.generateProjectResult = .success(.fixture())
		cacheManager.saveCacheIfNeededResult = .success(())

		try await sut.generate(from: graph)

		let inputs = Set(projectGenerator.inputs.value)
		XCTAssertEqual(inputs, [
			.generateProject(.fixture(projectInfo: .fixture(project: Project(name: "1")))),
			.generateProject(.fixture(projectInfo: .fixture(project: Project(name: "2")))),
		])
	}

	func test_Generate_SavesCacheIfNeeded_ForEachProvidedConfig() async throws {
		orderResolver.resolveResult = .success([
			.fixture(projectInfo: .fixture(project: Project(name: "1"))),
			.fixture(projectInfo: .fixture(project: Project(name: "2"))),
		])
		projectGenerator.generateProjectResult = .success(.fixture())
		cacheManager.saveCacheIfNeededResult = .success(())

		try await sut.generate(from: graph)

		XCTAssertEqual(cacheManager.inputs, [
			.saveCacheIfNeeded(.fixture(projectInfo: .fixture(project: Project(name: "1")))),
			.saveCacheIfNeeded(.fixture(projectInfo: .fixture(project: Project(name: "2")))),
		])
	}
}
