//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ProjectGraphBuilderKit
import ToolsCore
import Version
import XcodeGenKit

public struct XcodeGen {
	private let rootProject: String?
	private let mode: XcodeGenMode
	private let shell: Shell

	public init(
		rootProject: String? = nil,
		mode: XcodeGenMode,
		shell: Shell = ShellImpl()
	) {
		self.rootProject = rootProject
		self.mode = mode
		self.shell = shell
	}

	public func run() async throws {
		shell.print("Generating .xcodeproj files")
		// swiftlint:disable force_try
		let pathResolver = ProjectPathResolverImpl(basePath: try! GitImpl().topLevel())
		let fileManager = FileManager.default

		let graphBuilderKit = ProjectGraphBuilderKit(
			pathResolver: pathResolver,
			specLoader: XcodeSpecLoaderWrapper(),
			fileManager: fileManager,
			shell: shell
		)

		let xcodeProjGenerator = XcodeProjGeneratorImpl(pathResolver: pathResolver)

		let cacheRepository = CacheRepositoryImpl(
			pathResolver: pathResolver,
			cacheWriter: CacheWriterImpl(fileManager: fileManager),
			cacheLoader: CacheLoaderImpl(fileManager: fileManager)
		)

		let cacheManager = CacheManagerImpl(
			cacheRepository: cacheRepository,
			xcodeProjValidator: XcodeProjValidatorImpl()
		)

		let projectConfigProvider = RootProjectsConfigProviderImpl(
			configBuilder: graphBuilderKit.projectConfigBuilder,
			rootProject: rootProject
		)
		let rootProjects = projectConfigProvider.rootProjects()
		let workspaceProjectsGraph = try graphBuilderKit.graphBuilder.buildGraph(rootProjects: rootProjects).get()

		let projectGenerator = ProjectGeneratorImpl(
			projectValidator: ProjectValidatorImpl(),
			xcodeProjGenerator: xcodeProjGenerator,
			shell: shell
		)

		let timeMeasurer = ElapsedTimeMeasurerImpl()
		let performanceMeasuringGenerator = PerformanceMeasuringProjectGenerator(
			subject: projectGenerator,
			timeMeasurer: timeMeasurer
		)

		let projectsOrderResolver = ProjectsOrderResolverImpl(
			dfsFactory: CacheMarkingDFSFactory(cacheManager: cacheManager)
		)

		let workspaceGenerator = WorkspaceGeneratorImpl(
			projectGenerator: performanceMeasuringGenerator,
			orderResolver: projectsOrderResolver,
			cacheManager: cacheManager,
			mode: mode
		)

		let generationTime = try await timeMeasurer.measure {
			try await workspaceGenerator.generate(from: workspaceProjectsGraph)
		}

		print("All projects are generated in \(generationTime) seconds.".green)
	}
}
