//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ToolsCore
import XCTest

final class AdjacencyListTests: XCTestCase {
	private let dfs = ThreeColoredDFS<Int>()

	func test_FullyConnectedGraph_MakesExpected() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: three, to: one)
		try sut.addEdge(from: three, to: two)

		XCTAssertEqual(sut.adjacencyList, [
			one: Set([]),
			two: Set([one]),
			three: Set([one, two]),
		])
	}

	func test_FullyConnectedGraph_TopologicallySorted_ReturnsRightOrder() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: three, to: one)
		try sut.addEdge(from: three, to: two)

		let order = try sut.topologicallySorted(using: dfs).get()

		XCTAssertEqual(order, [three, two, one])
	}

	func test_UnconnectedGraph_MakesExpected() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)

		XCTAssertEqual(sut.adjacencyList, [
			one: Set([]),
			two: Set([]),
			three: Set([]),
		])
	}

	func test_UnconnectedGraph_TopologicallySorted_ReturnsAnyOrder() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)

		let order = try sut.topologicallySorted(using: dfs).get()

		XCTAssertTrue((order == [one, two]) || (order == [two, one]))
	}

	func test_DirectlyCycledGraph_MakesExpected() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: two)
		try sut.addEdge(from: three, to: two)

		XCTAssertEqual(sut.adjacencyList, [
			one: Set([two]),
			two: Set([one]),
			three: Set([two]),
		])
	}

	func test_DirectlyCycledGraph_TopologicallySorted_ReturnsCycleError() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: two)
		try sut.addEdge(from: three, to: two)

		let result = sut.topologicallySorted(using: dfs)

		assert_DFSError(result, .cycle(from: two, to: one))
	}

	func test_WholeGraphCycled_MakesExpected() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: three)
		try sut.addEdge(from: three, to: two)

		XCTAssertEqual(sut.adjacencyList, [
			one: Set([three]),
			two: Set([one]),
			three: Set([two]),
		])
	}

	func test_WholeGraphCycled_TopologicallySorted_ReturnsWholeGraphCycledError() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: three)
		try sut.addEdge(from: three, to: two)

		let result = sut.topologicallySorted(using: dfs)

		assert_SortingError(result, .wholeGraphCycled)
	}

	func test_IndirectlyCycledGraph_MakesExpected() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		let four = sut.makeNode(4)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: three)
		try sut.addEdge(from: three, to: two)
		try sut.addEdge(from: four, to: three)

		XCTAssertEqual(sut.adjacencyList, [
			one: Set([three]),
			two: Set([one]),
			three: Set([two]),
			four: Set([three]),
		])
	}

	func test_IndirectlyCycledGraph_TopologicallySorted_ReturnsCycleError() throws {
		var sut = AdjacencyList<Int>()
		let one = sut.makeNode(1)
		let two = sut.makeNode(2)
		let three = sut.makeNode(3)
		let four = sut.makeNode(4)
		try sut.addEdge(from: two, to: one)
		try sut.addEdge(from: one, to: three)
		try sut.addEdge(from: three, to: two)
		try sut.addEdge(from: four, to: three)

		let result = sut.topologicallySorted(using: dfs)

		assert_DFSError(result, .cycle(from: three, to: one))
	}

	func test_EmptyGraph_MakeExpected() {
		let sut = AdjacencyList<Int>()

		XCTAssertEqual(sut.adjacencyList, [:])
	}

	func test_EmptyGraph_TopologicallySorted_ReturnsEmptyOrder() throws {
		let sut = AdjacencyList<Int>()

		let order = try sut.topologicallySorted(using: dfs).get()

		XCTAssertEqual(order, [])
	}

	private func assert_SortingError(
		_ given: Result<[Node<Int>], Error>,
		_ expected: AdjacencyList<Int>.SortingError
	) {
		do {
			_ = try given.get()
			XCTFail("Must throw error")
		} catch {
			XCTAssertEqual(
				error as? AdjacencyList<Int>.SortingError,
				expected
			)
		}
	}

	private func assert_DFSError(
		_ given: Result<[Node<Int>], Error>,
		_ expected: DFS<Node<Int>>.TraverseError
	) {
		do {
			_ = try given.get()
			XCTFail("Must throw error")
		} catch {
			XCTAssertEqual(
				error as? DFS<Node<Int>>.TraverseError,
				expected
			)
		}
	}
}
