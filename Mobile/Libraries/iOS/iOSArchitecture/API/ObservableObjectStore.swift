import Foundation
import iOSUtilities

public actor ObservableObjectStore<S: Store>: ObservableObject {
	@MainActor
	@Published
	public var state: S.State

	private let subject: S

	@MainActor
	public init(
		_ initialState: S.State,
		_ subject: @escaping (S.State) -> S
	) {
		self.state = initialState
		self.subject = subject(initialState)
	}
	
	public func dispatch(action: S.Action) async {
		Task {
			let newState = await self.subject.dispatch(action) 
			await MainActor.run {
				self.state = newState
			}
		}
	}
}
