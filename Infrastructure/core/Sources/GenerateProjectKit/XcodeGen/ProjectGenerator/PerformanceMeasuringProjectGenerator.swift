//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Rainbow
import ToolsCore

final class PerformanceMeasuringProjectGenerator: ProjectGenerator {
	private let subject: ProjectGenerator
	private let timeMeasurer: ElapsedTimeMeasurer

	init(
		subject: ProjectGenerator,
		timeMeasurer: ElapsedTimeMeasurer
	) {
		self.subject = subject
		self.timeMeasurer = timeMeasurer
	}

	func generateProject(using config: ProjectConfig) throws -> GeneratedProjectInfo {
		var project: GeneratedProjectInfo?

		let generationTime = try timeMeasurer.measure {
			project = try subject.generateProject(using: config)
		}

		print("\(config.projectInfo.project.name) generated in \(generationTime) seconds.".green)
		return project!
	}
}
