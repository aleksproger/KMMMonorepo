//
//  Copyright © 2022 Sberbank. All rights reserved.
//

extension AdjacencyList {
	public enum SortingError: Equatable, Error {
		case wholeGraphCycled
	}

	public func topologicallySorted(using dfs: DFS<T>) -> Result<[Node<T>], Error> {
		do {
			let leafs = zeroIngoingLeafs()

			if leafs.isEmpty, !adjacencyList.isEmpty {
				throw SortingError.wholeGraphCycled
			}

			var result = [Node<T>]()

			for node in leafs {
				try dfs.dfs(
					root: node,
					graph: self,
					result: &result
				)
			}

			return .success(result.reversed())
		} catch {
			return .failure(error)
		}
	}

	private func zeroIngoingLeafs() -> [Node<T>] {
		var result = [Node<T>]()

		let nodesWithIngoingConnections = adjacencyList.values.reduce(Set<Node<T>>()) { result, anotherSet in
			result.union(anotherSet)
		}

		for node in existingNodes.values {
			if !nodesWithIngoingConnections.contains(node) {
				result.append(node)
			}
		}

		return result
	}
}
