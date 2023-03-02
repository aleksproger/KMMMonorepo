//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

protocol MarkingDFSFactory {
	func make(nodes: [Node<ProjectConfig>]) async throws -> ThreeColoredDFSWithMarkers<ProjectConfig>
}
