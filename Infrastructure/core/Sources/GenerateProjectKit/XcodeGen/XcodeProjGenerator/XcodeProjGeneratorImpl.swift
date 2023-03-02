//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import PathKit
import ProjectSpec
import ToolsCore
import XcodeGenKit
import XcodeProj

final class XcodeProjGeneratorImpl: XcodeProjGenerator {
	typealias ProjectGeneratorFactory = (Project) -> XcodeGenKit.ProjectGenerator
	typealias FileWriterFactory = (Project) -> FileWriter

	private let makeProjectGenerator: ProjectGeneratorFactory
	private let makeFileWriter: FileWriterFactory
	private let fileManager: FileManagerTwin
	private let pathResolver: ProjectPathResolver

	init(
		makeProjectGenerator: @escaping ProjectGeneratorFactory = XcodeGenKit.ProjectGenerator.init,
		makeFileWriter: @escaping FileWriterFactory = FileWriter.init,
		fileManager: FileManagerTwin = FileManager.default,
		pathResolver: ProjectPathResolver
	) {
		self.makeProjectGenerator = makeProjectGenerator
		self.makeFileWriter = makeFileWriter
		self.fileManager = fileManager
		self.pathResolver = pathResolver
	}

	@discardableResult
	func generateXcodeProj(
		_ projectInfo: ProjectInfo,
		in projectDirectory: ProjectPath
	) -> Result<XcodeProj, Error> {
		let projectGenerator = makeProjectGenerator(projectInfo.project)
		let fileWriter = makeFileWriter(projectInfo.project)

		do {
			let projectName = "\(projectInfo.project.name).xcodeproj"
			let projectPath = try pathResolver.resolve(path: .relative(to: projectDirectory, projectName)).get()
			let projectDirectory = try pathResolver.resolve(path: projectDirectory).get()

			if !fileManager.fileExists(atPath: projectDirectory) {
				try fileManager.createDirectory(
					atPath: projectDirectory,
					withIntermediateDirectories: true,
					attributes: nil
				)
			}

			try fileWriter.writePlists()
			let xcodeProject = try projectGenerator.generateXcodeProject(in: Path(projectDirectory))
			try fileWriter.writeXcodeProject(xcodeProject, to: Path(projectPath))
			return .success(xcodeProject)
		} catch {
			return .failure(error)
		}
	}
}
