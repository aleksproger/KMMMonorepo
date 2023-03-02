//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Rainbow
import ToolsCore

final class ProjectConfigBuilderImpl: ProjectConfigBuilder {
	private let specLoader: ProjectSpecLoader
	private let shell: Shell
	private let makeSpecPath: (String) -> ProjectPath
	private let makeDirectoryPath: (String) -> ProjectPath
	private let makeCachePath: (String) -> ProjectPath

	init(
		specLoader: ProjectSpecLoader,
		shell: Shell,
		makeSpecPath: @escaping (String) -> ProjectPath = ProjectPath.xcSpecPath,
		makeDirectoryPath: @escaping (String) -> ProjectPath = ProjectPath.directoryPath,
		makeCachePath: @escaping (String) -> ProjectPath = ProjectPath.xcCachePath
	) {
		self.specLoader = specLoader
		self.shell = shell
		self.makeSpecPath = makeSpecPath
		self.makeDirectoryPath = makeDirectoryPath
		self.makeCachePath = makeCachePath
	}

	func config(_ projectName: String) -> ProjectConfig? {
		do {
			let specPath = makeSpecPath(projectName)
			let projectInfo = try specLoader.loadSpec(at: specPath).get()
			return ProjectConfig(
				projectInfo: projectInfo,
				directoryPath: makeDirectoryPath(projectName),
				cachePath: makeCachePath(projectName),
				quiet: false
			)
		} catch let error as ProjectSpecLoaderError {
			print("\(error)".yellow)
			return nil
		} catch {
			print("\(error)".red)
			fatalError(error.localizedErrorDescription)
		}
	}
}
