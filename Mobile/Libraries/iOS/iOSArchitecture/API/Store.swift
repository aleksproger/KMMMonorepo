import Foundation

public protocol Store {
	associatedtype Action
	associatedtype State
	associatedtype Effect

	func dispatch(_ action: Action) async -> State
}