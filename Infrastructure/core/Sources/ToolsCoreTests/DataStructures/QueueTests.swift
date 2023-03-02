//
//  Copyright © 2021 Sberbank. All rights reserved.
//

@testable import ToolsCore
import XCTest

final class QueueTests: XCTestCase {
	private lazy var sut = Queue(list)
	private var list = [1, 2]

	// MARK: - Enqueue

	func test_Enqueue_AddsItemToEnd() {
		sut.enqueue(4)

		XCTAssertEqual(sut.dequeue(), 1)
		XCTAssertEqual(sut.dequeue(), 2)
		XCTAssertEqual(sut.dequeue(), 4)
	}

	// MARK: - Dequeue

	func test_Dequeue_RemovesItemFromBegining() {
		XCTAssertEqual(sut.dequeue(), 1)
		XCTAssertEqual(sut.dequeue(), 2)
		XCTAssertNil(sut.dequeue())
	}

	func test_Dequeue_WhenQueueDoesNotContainItems_ReturnNil() {
		list = []

		XCTAssertNil(sut.dequeue())
	}

	func test_Dequeue_WhenListIsHuge_ReturnsFirst() {
		list = Array(0 ... 100_000)

		XCTAssertEqual(sut.dequeue(), 0)
		XCTAssertEqual(sut.dequeue(), 1)
	}

	// MARK: - Peek

	func test_Peek_DoesNotRemoveItem() {
		XCTAssertEqual(sut.peek(), 1)

		XCTAssertFalse(sut.isEmpty)
		XCTAssertEqual(sut.dequeue(), 1)
		XCTAssertEqual(sut.dequeue(), 2)
		XCTAssertTrue(sut.isEmpty)
	}

	func test_Peek_WhenQueueDoesNotContainItems_ReturnNil() {
		list = []

		XCTAssertNil(sut.peek())
	}

	// MARK: - IsEmpty

	func test_IsEmpty_WhenQueueDoesNotContainItems_ReturnsTrue() {
		list = []

		XCTAssertTrue(sut.isEmpty)
	}

	func test_IsEmpty_WhenQueueContainsItems_ReturnsFalse() {
		XCTAssertFalse(sut.isEmpty)
	}

	// MARK: - Size

	func test_Count_ReturnsListSize() {
		XCTAssertEqual(sut.count, 2)
	}

	func test_Count_WhenQueueDoesNotContainItems_ReturnsListSize() {
		list = []

		XCTAssertEqual(sut.count, 0)
	}

	// MARK: - Clean

	func test_Clean_CleansQueue() {
		sut.clean()

		XCTAssertTrue(sut.isEmpty)
	}

	func test_Clean_WhenQueueIsEmpty_CleansQueue() {
		list = []

		sut.clean()

		XCTAssertTrue(sut.isEmpty)
	}

	func test_3EnqueuesAnd2Dequeues_PeekIsLastEnqueued() {
		list = []

		sut.enqueue(1)
		sut.dequeue()
		sut.enqueue(2)
		sut.enqueue(3)
		sut.dequeue()

		XCTAssertEqual(sut.peek(), 3)
	}
}

private enum Job {
	case enqueue
	case dequeue
}

extension Queue where T == Int {
	fileprivate mutating func makeRandomJobMock(array: inout [Int]) {
		let currentJob = [Job.enqueue, Job.dequeue].randomElement()!

		switch currentJob {
		case .dequeue:
			self.dequeue()
			_ = array.removeFirst()
		case .enqueue:
			let item = Int.makeRandom()
			self.enqueue(item)
			array.append(item)
		}
	}
}

extension Int {
	fileprivate static func makeArray(_ count: Int = 100) -> [Int] {
		(0 ..< count).map { _ in Int.makeRandom() }
	}

	fileprivate static func makeRandom(_ range: Range<Int32> = 1 ..< INT32_MAX) -> Int {
		Int(Int32.random(in: range))
	}
}
