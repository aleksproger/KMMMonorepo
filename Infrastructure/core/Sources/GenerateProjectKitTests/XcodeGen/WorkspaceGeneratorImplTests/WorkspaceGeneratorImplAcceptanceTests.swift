//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
@testable import GenerateProjectKit
import GenerateProjectTestKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit
@testable import XcodeProj
import XCTest

final class WorkspaceGeneratorImplAcceptanceTest: XCTestCase {
	private lazy var acceptanceTesting = XcodeGen.AcceptanceTesting()

	private lazy var firstProject: ProjectConfig = {
		ProjectConfig(
			projectInfo: loadSpec(specName: "first_project"),
			directoryPath: .absolute(Env.testDataDirectory),
			cachePath: .absolute("\(Env.outputDirectory)/first.d"),
			quiet: false
		)
	}()

	private lazy var secondProject: ProjectConfig = {
		ProjectConfig(
			projectInfo: loadSpec(specName: "second_project"),
			directoryPath: .absolute(Env.testDataDirectory),
			cachePath: .absolute("\(Env.outputDirectory)/second.d"),
			quiet: false
		)
	}()

	private lazy var thirdProject: ProjectConfig = {
		ProjectConfig(
			projectInfo: loadSpec(specName: "third_project"),
			directoryPath: .absolute(Env.testDataDirectory),
			cachePath: .absolute("\(Env.outputDirectory)/third.d"),
			quiet: false
		)
	}()

	private lazy var modifiedProject: ProjectConfig = {
		ProjectConfig(
			projectInfo: loadSpec(specName: "modified_project"),
			directoryPath: .absolute(Env.testDataDirectory),
			cachePath: .absolute("\(Env.outputDirectory)/third.d"),
			quiet: false
		)
	}()

	override func tearDown() {
		super.tearDown()

		acceptanceTesting.cleanUp(outputDirectory: Env.outputDirectory, testDataDirectory: Env.testDataDirectory)
	}

	func test_Regenerate_ProjectsWithoutChanges_DoesNotRegenerateProjects() async throws {
		let graph: AdjacencyList<ProjectConfig> = try .treeShapedGraphFixture(
			firstProject: firstProject,
			secondProject: secondProject,
			thirdProject: thirdProject
		)

		let firstGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)
		let secondGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)

		XCTAssertEqual(firstGenerateResult.map(\.specProject), [
			thirdProject.projectInfo.project,
			secondProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
		XCTAssertEqual(secondGenerateResult, [])
	}

	func test_Regenerate_ProjectsWithoutChanges_XcodeProjFilesDeleted_RegenerateProjects() async throws {
		let graph: AdjacencyList<ProjectConfig> = try .treeShapedGraphFixture(
			firstProject: firstProject,
			secondProject: secondProject,
			thirdProject: thirdProject
		)
		let firstGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)
		acceptanceTesting.removePBXProjFiles(outputDirectory: Env.outputDirectory, testDataDirectory: Env.testDataDirectory)

		let secondGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)

		XCTAssertEqual(firstGenerateResult.map(\.specProject), [
			thirdProject.projectInfo.project,
			secondProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
		XCTAssertEqual(secondGenerateResult.map(\.specProject), [
			thirdProject.projectInfo.project,
			secondProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
	}

	func test_Regenerate_ProjectsWithoutChanges_XcodeProjFilesExistButInvalid_RegenerateProjects() async throws {
		let graph: AdjacencyList<ProjectConfig> = try .treeShapedGraphFixture(
			firstProject: firstProject,
			secondProject: secondProject,
			thirdProject: thirdProject
		)
		let firstGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)
		acceptanceTesting.cleanUp(outputDirectory: Env.outputDirectory, testDataDirectory: Env.testDataDirectory)

		let secondGenerateResult = try await acceptanceTesting.workspaceGenerator.generate(from: graph)

		XCTAssertEqual(firstGenerateResult.map(\.specProject), [
			thirdProject.projectInfo.project,
			secondProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
		XCTAssertEqual(secondGenerateResult.map(\.specProject), [
			thirdProject.projectInfo.project,
			secondProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
	}

	func test_Regenerate_ProjectsHaveChangedProjectSpec_RegeneratesChangedAndAllDependantProjects() async throws {
		let initialGraph: AdjacencyList<ProjectConfig> = try .treeShapedGraphFixture(
			firstProject: firstProject,
			secondProject: secondProject,
			thirdProject: thirdProject
		)
		try await acceptanceTesting.workspaceGenerator.generate(from: initialGraph)

		let modifiedGraph: AdjacencyList<ProjectConfig> = try .treeShapedGraphFixture(
			firstProject: firstProject,
			secondProject: modifiedProject,
			thirdProject: thirdProject
		)
		let regeneratedProjects = try await acceptanceTesting.workspaceGenerator.generate(from: modifiedGraph)

		XCTAssertEqual(regeneratedProjects.map(\.specProject), [
			modifiedProject.projectInfo.project,
			firstProject.projectInfo.project,
		])
	}

	private func loadSpec(specName: String) -> ProjectInfo {
		// swiftlint:disable force_try
		try! acceptanceTesting.projectSpecLoader.loadSpec(
			at: .absolute("\(Env.testDataDirectory)/\(specName).yml")
		).get()
	}
}

private enum Env {
	static let testDataDirectory = "\(NSString(string: "\(#filePath)").deletingLastPathComponent)/TestData"
	static let specPath = "\(testDataDirectory)/project.yml"
	static let outputDirectory = "\(testDataDirectory)/output"
}
