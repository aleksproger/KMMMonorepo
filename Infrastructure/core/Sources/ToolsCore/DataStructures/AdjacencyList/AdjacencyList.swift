//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

public struct AdjacencyList<T: Hashable>: Hashable {
	enum GraphError: Error {
		case unknownNode(Node<T>)
	}

	public private(set) var adjacencyList: [Node<T>: Set<Node<T>>] = [:]
	private(set) var existingNodes = [T: Node<T>]()

	public init() {}

	public mutating func makeNode(_ value: T) -> Node<T> {
		if let node = existingNodes[value] {
			return node
		}

		let node = Node(value)
		existingNodes[value] = node
		adjacencyList[node] = []
		return node
	}

	public mutating func addEdge(from: Node<T>, to: Node<T>) throws {
		guard var fromEdges = adjacencyList.removeValue(forKey: from) else {
			throw GraphError.unknownNode(from)
		}

		fromEdges.insert(to)
		adjacencyList[from] = fromEdges
	}
}
