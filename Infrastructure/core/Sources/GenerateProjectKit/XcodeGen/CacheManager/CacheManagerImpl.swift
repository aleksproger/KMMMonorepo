//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

final class CacheManagerImpl: CacheManager {
	private let cacheRepository: CacheRepository
	private let xcodeProjValidator: XcodeProjValidator

	init(
		cacheRepository: CacheRepository,
		xcodeProjValidator: XcodeProjValidator
	) {
		self.cacheRepository = cacheRepository
		self.xcodeProjValidator = xcodeProjValidator
	}

	func shouldUseCache(for config: ProjectConfig) -> Result<Bool, Error> {
		do {
			guard let cachePath = config.cachePath else {
				print("No cache would be used for \(config.projectInfo.project.name), due to nil cachePath".yellow)
				return .success(false)
			}

			do {
				_ = try xcodeProjValidator.isValid(path: config.projectInfo.project.defaultProjectPath).get()
			} catch {
				print("No cache would be used for \(config.projectInfo.project.name), reason: \(error)".yellow)
				return .success(false)
			}

			let currentCache = try cacheRepository.computeCache(projectInfo: config.projectInfo).get()
			let previousCache = try cacheRepository.fetchLastCache(cachePath: cachePath).get()

			guard currentCache != previousCache else {
				return .success(true)
			}

			print("No cache would be used for \(config.projectInfo.project.name), due to changes in project".yellow)
			return .success(false)
		} catch {
			return .failure(error)
		}
	}

	@discardableResult
	func saveCacheIfNeeded(for config: ProjectConfig) -> Result<Void, Error> {
		do {
			guard let cachePath = config.cachePath else {
				return .success(())
			}
			let currentCache = try cacheRepository.computeCache(projectInfo: config.projectInfo).get()
			try cacheRepository.save(currentCache, to: cachePath).get()
			return .success(())
		} catch {
			return .failure(error)
		}
	}
}
