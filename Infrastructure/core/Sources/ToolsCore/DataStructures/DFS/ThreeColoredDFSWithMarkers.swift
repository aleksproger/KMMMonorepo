//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public final class ThreeColoredDFSWithMarkers<T: Hashable>: DFS<T> {
	public enum NodeStatus: Int {
		case visited
		case inProgress
		case notVisited
	}

	public private(set) var markedNodes = Set<Node<T>>()
	private var traverseMap = [Node<T>: NodeStatus]()

	private let markableNodes: Set<Node<T>>

	public init(
		markableNodes: Set<Node<T>>
	) {
		self.markableNodes = markableNodes
		super.init()
	}

	public override func dfs(
		root: Node<T>,
		graph: AdjacencyList<T>,
		result: inout [Node<T>]
	) throws {
		guard traverseMap[root] != .visited else {
			return
		}

		if markableNodes.contains(root) {
			markedNodes.insert(root)
		}

		traverseMap[root] = .inProgress

		for node in graph.adjacencyList[root, default: []] {
			if markedNodes.contains(root) { markedNodes.insert(node) }
			if isVisited(node) { continue }
			if isInProgress(node) { throw DFS<Node<T>>.TraverseError.cycle(from: node, to: root) }

			try dfs(root: node, graph: graph, result: &result)
		}

		traverseMap[root] = .visited
		result.append(root)
	}

	public func isVisited(_ node: Node<T>) -> Bool {
		traverseMap[node, default: .notVisited] == .visited
	}

	public func isInProgress(_ node: Node<T>) -> Bool {
		traverseMap[node, default: .notVisited] == .inProgress
	}
}
