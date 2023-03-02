//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

protocol CacheRepository {
	func computeCache(projectInfo: ProjectInfo) -> Result<String, Error>
	func fetchLastCache(cachePath: ProjectPath) -> Result<String?, Error>
	func save(_ cache: String, to cachePath: ProjectPath) -> Result<Void, Error>
}
