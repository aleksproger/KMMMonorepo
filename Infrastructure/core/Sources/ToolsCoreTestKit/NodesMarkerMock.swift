//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ToolsCore

public final class NodesMarkerMock {
	public enum Input: Equatable {
		case mark(Node<Int>)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var markingMap: [Node<Int>: Bool] = [:]
	public func mark(_ node: Node<Int>) -> Bool {
		inputs.append(.mark(node))
		return markingMap[node] ?? false
	}
}
