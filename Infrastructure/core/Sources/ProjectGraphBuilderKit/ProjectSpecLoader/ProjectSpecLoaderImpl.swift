//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ProjectSpec
import ToolsCore

public final class ProjectSpecLoaderImpl: ProjectSpecLoader {
	private let fileManager: FileManagerTwin
	private let specLoader: SpecLoaderWrapper
	private let pathResolver: ProjectPathResolver
	private let shell: Shell

	public init(
		fileManager: FileManagerTwin,
		specLoader: SpecLoaderWrapper,
		pathResolver: ProjectPathResolver,
		shell: Shell
	) {
		self.fileManager = fileManager
		self.specLoader = specLoader
		self.pathResolver = pathResolver
		self.shell = shell
	}

	public func loadSpec(at path: ProjectPath) -> Result<ProjectGraphBuilderKit.ProjectInfo, Error> {
		do {
			let fullPath = try pathResolver.resolve(path: path).get()

			guard fileManager.fileExists(atPath: fullPath) else {
				shell.print("Skip spec from \(fullPath), due to missing project.yml file".cyan)
				return .failure(ProjectSpecLoaderError.specFileNotFound)
			}

			shell.print("Loading spec from \(fullPath)...")

			let project = try specLoader.loadProject(
				path: fullPath,
				projectRoot: nil,
				variables: [:]
			).get()

			guard let projectDict = specLoader.projectDictionary else {
				shell.print("Failed to load spec at path \(fullPath)".red)
				return .failure(ProjectSpecLoaderError.unableToResolveProjectDictionary)
			}

			return .success(ProjectInfo(
				project: project,
				projectDict: projectDict
			))
		} catch {
			return .failure(error)
		}
	}
}
