import Foundation

public protocol Store {
	associatedtype Action
	associatedtype State
		
	func dispatch(_ action: Action)
}