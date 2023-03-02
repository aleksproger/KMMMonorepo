//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ToolsCore
import XCTest

final class StackTests: XCTestCase {
	private lazy var sut = Stack(array)

	private var array = [Item]()

	func test_PushElement_PeekIsEqualToInsertable() {
		let item = Item()

		sut.push(item)

		XCTAssertEqual(item, sut.peek())
	}

	func test_PopElement_ReleasesElement() {
		sut.push(Item())

		sut.pop()

		XCTAssertNil(sut.peek())
	}

	func test_PopElement_ThisEqualToInsertable() {
		let item = Item()
		sut.push(item)

		XCTAssertEqual(item, sut.pop())
	}

	func test_PopManyValues_AllElementsPopItReverseOrder() {
		array = Item.makeArray()
		_ = sut

		XCTAssertTrue(array.reversed().allSatisfy { sut.pop() == $0 })
	}

	func test_ClearStack_StackIsEmpty() {
		array = Item.makeArray()
		_ = sut

		sut.clean()

		XCTAssertTrue(sut.isEmpty)
	}

	func test_ReplaceElement_ReplacedElementAtPeek() {
		sut.push(Item())
		let item = Item()

		sut.replace(item)

		XCTAssertEqual(sut.peek(), item)
	}

	func test_ReplaceElement_CountDidNotChange() {
		array = Item.makeArray()
		_ = sut
		let item = Item()

		sut.replace(item)

		XCTAssertEqual(sut.count, array.count)
	}

	func test_StressTest_StackIsStable() {
		array = Item.makeArray()
		_ = sut
		let stressIterations = 100_000

		for _ in 0 ..< stressIterations {
			sut.makeRandomJobMock(array: &array)

			let currentPeak = array.last
			XCTAssertEqual(currentPeak, sut.peek())
			XCTAssertEqual(array.count, sut.count)
		}
	}
}

private enum Job {
	case pop
	case push
	case replace
}

extension Stack where T == Item {
	fileprivate mutating func makeRandomJobMock(array: inout [Item]) {
		let currentJob = [Job.pop, Job.push, Job.replace].randomElement()!

		switch currentJob {
		case .pop:
			self.pop()
			_ = array.popLast()
		case .push:
			let item = Item()
			self.push(item)
			array.append(item)
		case .replace:
			let item = Item()
			self.replace(item)
			_ = array.popLast()
			array.append(item)
		}
	}
}

private class Item: Equatable {
	static func == (lhs: Item, rhs: Item) -> Bool {
		lhs === rhs
	}

	static func makeArray(_ count: Int = 100) -> [Item] {
		(0 ..< count).map { _ in Item() }
	}
}
