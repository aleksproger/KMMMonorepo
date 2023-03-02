//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

final class CacheMarkingDFSFactory: MarkingDFSFactory {
	private let cacheManager: CacheManager

	init(cacheManager: CacheManager) {
		self.cacheManager = cacheManager
	}

	func make(nodes: [Node<ProjectConfig>]) async throws -> ThreeColoredDFSWithMarkers<ProjectConfig> {
		let markableNodes: [Node<ProjectConfig>] = try await nodes.concurrentCompactMap { [cacheManager] node in
			let shouldMarkNode = try !cacheManager.shouldUseCache(for: node.value).get()
			return shouldMarkNode ? node : nil
		}

		let dfs = ThreeColoredDFSWithMarkers<ProjectConfig>(
			markableNodes: Set(markableNodes)
		)
		return dfs
	}
}
