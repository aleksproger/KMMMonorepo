//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public class DFS<T: Hashable> {
	public enum TraverseError: Error, Equatable {
		case cycle(from: T, to: T)
	}

	public func dfs(
		root _: Node<T>,
		graph _: AdjacencyList<T>,
		result _: inout [Node<T>]
	) throws {
		fatalError("Implement the abstract class requirement")
	}
}
