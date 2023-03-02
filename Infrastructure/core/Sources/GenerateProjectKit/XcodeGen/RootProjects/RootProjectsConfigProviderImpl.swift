//
//  Created by Уразов Сергей Анатольевич on 26.08.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ProjectGraphBuilderKit

final class RootProjectsConfigProviderImpl: RootProjectsConfigProvider {
	private let configBuilder: ProjectConfigBuilder
	private let rootProject: String?

	init(
		configBuilder: ProjectConfigBuilder,
		rootProject: String?
	) {
		self.configBuilder = configBuilder
		self.rootProject = rootProject
	}

	func rootProjects() -> [ProjectConfig] {
		guard let rootProject = rootProject else {
			print("No custom root project was provided. All default root projects would be generated.".green)
			return defaultRootProjects()
		}

		guard let rootConfig = configBuilder.config(rootProject) else {
			print("Unable to construct config for provided project \(rootProject). Check that it exists.".yellow)
			return []
		}

		print("Graph would be generated from provided root project \(rootProject)")
		return [rootConfig]
	}

	private func defaultRootProjects() -> [ProjectConfig] {
		RootProjects.allCases.map { configBuilder.config($0.rawValue)! }
	}
}
