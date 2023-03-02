//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

final class CacheWriterImpl: CacheWriter {
	typealias WriteCache = (String, URL) throws -> Void

	private let fileManager: FileManagerTwin
	private let writeCache: WriteCache

	init(
		fileManager: FileManagerTwin,
		writeCache: @escaping WriteCache = { try $0.write(to: $1, atomically: true, encoding: .utf8) }
	) {
		self.fileManager = fileManager
		self.writeCache = writeCache
	}

	func write(cache: String, to path: String) throws {
		if !fileManager.fileExists(atPath: path) {
			try fileManager.createDirectory(
				atPath: NSString(string: path).deletingLastPathComponent,
				withIntermediateDirectories: true,
				attributes: nil
			)
		}
		try writeCache(cache, URL(fileURLWithPath: path))
	}
}
