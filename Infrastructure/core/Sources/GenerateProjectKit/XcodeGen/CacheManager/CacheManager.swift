//
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol CacheManager {
	func shouldUseCache(for config: ProjectConfig) -> Result<Bool, Error>

	@discardableResult
	func saveCacheIfNeeded(for config: ProjectConfig) -> Result<Void, Error>
}
