//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
@testable import GenerateProjectKit
@testable import ProjectGraphBuilderKit
import ProjectSpec
import ToolsCore
import ToolsCoreTestKit

extension XcodeGen {
	public struct AcceptanceTesting {
		public init() {}

		// swiftlint:disable force_try
		public lazy var pathResolver = ProjectPathResolverImpl(basePath: try! GitImpl().topLevel())

		public lazy var fileManager = FileManager.default
		public lazy var shell = ShellImpl()
		private var mode: XcodeGenMode = .fast

		public lazy var xcodeProjValidator = XcodeProjValidatorImpl()

		public lazy var projectSpecLoader = ProjectSpecLoaderImpl(
			fileManager: fileManager,
			specLoader: XcodeSpecLoaderWrapper(),
			pathResolver: pathResolver,
			shell: shell
		)

		public lazy var xcodeProjGenerator = XcodeProjGeneratorImpl(pathResolver: pathResolver)

		public lazy var cacheRepository = CacheRepositoryImpl(
			pathResolver: pathResolver,
			cacheWriter: CacheWriterImpl(fileManager: fileManager),
			cacheLoader: CacheLoaderImpl(fileManager: fileManager)
		)

		public lazy var cacheManager = CacheManagerImpl(
			cacheRepository: cacheRepository,
			xcodeProjValidator: xcodeProjValidator
		)

		public lazy var projectGenerator = ProjectGeneratorImpl(
			projectValidator: ProjectValidatorImpl(),
			xcodeProjGenerator: xcodeProjGenerator,
			shell: shell
		)

		public lazy var projectsOrderResolver = ProjectsOrderResolverImpl(
			dfsFactory: CacheMarkingDFSFactory(cacheManager: cacheManager)
		)

		public lazy var workspaceGenerator = WorkspaceGeneratorImpl(
			projectGenerator: projectGenerator,
			orderResolver: projectsOrderResolver,
			cacheManager: cacheManager,
			mode: mode
		)

		public mutating func cleanUp(
			outputDirectory: String,
			testDataDirectory: String
		) {
			guard let outputPath = try? pathResolver.resolve(path: .absolute(outputDirectory)).get(),
				  let testDataDirectoryPath = try? pathResolver.resolve(path: .absolute(testDataDirectory)).get(),
				  let testDataURL = URL(string: testDataDirectoryPath),
				  let allTestData = try? fileManager.contentsOfDirectory(at: testDataURL, includingPropertiesForKeys: nil)
			else {
				return
			}

			let xcodeProjFiles = allTestData.filter { $0.pathExtension.elementsEqual("xcodeproj") }
			for xcodeProjFile in xcodeProjFiles {
				try? fileManager.removeItem(at: xcodeProjFile)
			}
			try? fileManager.removeItem(atPath: outputPath)
		}

		public mutating func removePBXProjFiles(
			outputDirectory: String,
			testDataDirectory: String
		) {
			guard let outputPath = try? pathResolver.resolve(path: .absolute(outputDirectory)).get(),
				  let testDataDirectoryPath = try? pathResolver.resolve(path: .absolute(testDataDirectory)).get(),
				  let testDataURL = URL(string: testDataDirectoryPath),
				  let allTestData = try? fileManager.contentsOfDirectory(at: testDataURL, includingPropertiesForKeys: nil)
			else {
				return
			}

			let xcodeProjFiles = allTestData.filter { $0.pathExtension.elementsEqual("xcodeproj") }
			for xcodeProjFile in xcodeProjFiles {
				try? fileManager.removeItem(at: URL(fileURLWithPath: "\(xcodeProjFile)/project.pbxproj"))
			}
			try? fileManager.removeItem(atPath: outputPath)
		}
	}
}
