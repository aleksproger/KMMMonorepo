//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Rainbow
import ToolsCore
import XcodeProj

final class ProjectGeneratorImpl: ProjectGenerator {
	private let projectValidator: ProjectValidator
	private let xcodeProjGenerator: XcodeProjGenerator
	private let shell: Shell

	init(
		projectValidator: ProjectValidator,
		xcodeProjGenerator: XcodeProjGenerator,
		shell: Shell
	) {
		self.projectValidator = projectValidator
		self.xcodeProjGenerator = xcodeProjGenerator
		self.shell = shell
	}

	func generateProject(using config: ProjectConfig) throws -> GeneratedProjectInfo {
		shell.print("Validating project \(config.projectInfo.project.name)")
		try projectValidator.validate(info: config.projectInfo).get()

		shell.print("Generate project from: \(config.directoryPath)".blue)
		let xcodeProject = try xcodeProjGenerator.generateXcodeProj(config.projectInfo, in: config.directoryPath).get()

		shell.print("Project generated successfully \(config.projectInfo.project.name)".green)

		return GeneratedProjectInfo(
			xcodeProject: xcodeProject,
			specProject: config.projectInfo.project
		)
	}
}
