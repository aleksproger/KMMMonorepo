//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

final class CacheLoaderImpl: CacheLoader {
	private let fileManager: FileManagerTwin
	private let makeString: (String) throws -> String

	init(
		fileManager: FileManagerTwin,
		makeString: @escaping (String) throws -> String = { try String(contentsOfFile: $0, encoding: .utf8) }
	) {
		self.fileManager = fileManager
		self.makeString = makeString
	}

	func loadCache(from path: String) -> Result<String?, Error> {
		guard fileManager.fileExists(atPath: path) else {
			return .success(nil)
		}

		do {
			let cacheString = try makeString(path)
			return .success(cacheString)
		} catch {
			return .failure(error)
		}
	}
}
