import Foundation

public struct Stack<T> {
	private var list: [T] = []

	public var isEmpty: Bool {
		list.isEmpty
	}

	public var count: Int {
		list.count
	}

	public init(_ array: [T] = []) {
		self.list = array
	}

	public mutating func push(_ element: T) {
		list.append(element)
	}

	@discardableResult
	public mutating func pop() -> T? {
		list.popLast()
	}

	public func peek() -> T? {
		list.last
	}

	public mutating func clean() {
		list.removeAll()
	}

	public mutating func replace(_ element: T) {
		pop()
		push(element)
	}
}
