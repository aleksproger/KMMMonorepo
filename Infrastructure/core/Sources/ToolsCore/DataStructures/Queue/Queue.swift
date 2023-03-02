//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public struct Queue<T> {
	private var inStack: Stack<T>
	private var outStack: Stack<T>

	public var isEmpty: Bool {
		inStack.isEmpty && outStack.isEmpty
	}

	public var count: Int {
		inStack.count + outStack.count
	}

	public init(_ list: [T] = []) {
		self.inStack = Stack<T>(list)
		self.outStack = Stack<T>()
	}

	public mutating func enqueue(_ element: T) {
		inStack.push(element)
	}

	@discardableResult
	public mutating func dequeue() -> T? {
		transferElementsIfNeeded()
		return outStack.pop()
	}

	public mutating func peek() -> T? {
		transferElementsIfNeeded()
		return outStack.peek()
	}

	public mutating func clean() {
		outStack.clean()
		inStack.clean()
	}

	private mutating func transferElementsIfNeeded() {
		guard outStack.isEmpty else {
			return
		}

		while let element = inStack.pop() {
			outStack.push(element)
		}
	}
}
