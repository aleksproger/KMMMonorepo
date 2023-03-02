import Foundation

class ObservableObjectStore<S: Store>: ObservableObject {
	@Published
	var state: S.State
	
	lazy var subject: S = makeStateContainer(state, { newState in
		onMainThread { self.state = newState }
	})
	
	private let makeStateContainer: (S.State, @escaping (S.State) -> Void) -> S

	init(
		_ makeInitialState: @autoclosure () -> S.State,
		_ makeStateContainer: @escaping (S.State, @escaping (S.State) -> Void) -> S,
		_ mainThreadRunner: MainThreadRunner = onMainThread
	) {
		self.state = makeInitialState()
		self.makeStateContainer = makeStateContainer
	}
	
	func dispatch(action: S.Action) {
		subject.dispatch(action)
	}
}
