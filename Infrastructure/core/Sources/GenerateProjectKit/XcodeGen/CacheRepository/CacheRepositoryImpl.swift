//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ProjectSpec
import ToolsCore

final class CacheRepositoryImpl: CacheRepository {
	private let pathResolver: ProjectPathResolver
	private let cacheWriter: CacheWriter
	private let cacheLoader: CacheLoader
	private let shell: Shell

	init(
		pathResolver: ProjectPathResolver,
		cacheWriter: CacheWriter,
		cacheLoader: CacheLoader,
		shell: Shell = ShellImpl()
	) {
		self.pathResolver = pathResolver
		self.cacheWriter = cacheWriter
		self.cacheLoader = cacheLoader
		self.shell = shell
	}

	func computeCache(projectInfo: ProjectInfo) -> Result<String, Error> {
		shell.print("Computing current build cache for \(projectInfo.project.name)")
		do {
			let rawCacheFile = try CacheFileTwin(projectInfo: projectInfo).string
			return .success(rawCacheFile)
		} catch {
			return .failure(error)
		}
	}

	func fetchLastCache(cachePath: ProjectPath) -> Result<String?, Error> {
		shell.print("Retrieving previous build cache from \(cachePath)")
		do {
			let rawCachePath = try pathResolver.resolve(path: cachePath).get()
			return cacheLoader.loadCache(from: rawCachePath)
		} catch {
			return .failure(error)
		}
	}

	func save(_ cache: String, to cachePath: ProjectPath) -> Result<Void, Error> {
		shell.print("Saving new cache at \(cachePath)\n")
		do {
			let rawCachePath = try pathResolver.resolve(path: cachePath).get()
			try cacheWriter.write(cache: cache, to: rawCachePath)
			return .success(())
		} catch {
			return .failure(error)
		}
	}
}
