//
//  Copyright © 2021 Sberbank. All rights reserved.
//

public struct Node<T: Hashable>: Hashable {
	public var value: T

	public init(_ value: T) {
		self.value = value
	}
}
