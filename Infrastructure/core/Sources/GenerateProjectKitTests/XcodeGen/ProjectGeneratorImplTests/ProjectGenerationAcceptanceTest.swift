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

final class ProjectGenerationAcceptanceTest: XCTestCase {
	private lazy var acceptanceTesting = XcodeGen.AcceptanceTesting()

	override func tearDown() {
		super.tearDown()

		acceptanceTesting.cleanUp(
			outputDirectory: Env.outputDirectory,
			testDataDirectory: Env.testDataDirectory
		)
	}

	func test_GenerateProject_GeneratesProjectAccordingToSpec() async throws {
		let projectInfo = try acceptanceTesting.projectSpecLoader.loadSpec(at: .absolute(Env.specPath)).get()
		_ = try acceptanceTesting.projectGenerator.generateProject(using: ProjectConfig(
			projectInfo: projectInfo,
			directoryPath: .absolute(Env.outputDirectory),
			cachePath: nil,
			quiet: false
		))

		let project = try XcodeProj(pathString: Env.xcodeProjPath)

		try ProjectMatcher(
			expectedName: "ExampleProject",
			expectedTargets: [
				.application(dependencies: ["ExampleFramework"]),
				.framework(),
			]
		).match(project)
	}
}

private enum Env {
	static let testDataDirectory = "\(NSString(string: "\(#filePath)").deletingLastPathComponent)/TestData"
	static let specPath = "\(testDataDirectory)/project.yml"
	static let outputDirectory = "\(testDataDirectory)/output"
	static let xcodeProjPath = "\(outputDirectory)/ExampleProject.xcodeproj"
}
