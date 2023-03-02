//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public final class NodesProviderMock {
	public enum Input: Equatable {
		case provide(Int)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var providerMap: [Int: [Int]] = [:]
	public func provide(_ node: Int) -> [Int] {
		inputs.append(.provide(node))
		return providerMap[node] ?? []
	}
}
