import Foundation
import iOSUtilities

public final class ObservableObjectStore<S: Store>: ObservableObject {
	@Published
	public var state: S.State
	
	private lazy var subject: S = makeStateContainer(state, { newState in
		onMainThread { self.state = newState }
	})
	
	private let makeStateContainer: (S.State, @escaping (S.State) -> Void) -> S

	public init(
		_ makeInitialState: @autoclosure () -> S.State,
		_ makeStateContainer: @escaping (S.State, @escaping (S.State) -> Void) -> S,
		_ mainThreadRunner: MainThreadRunner = onMainThread
	) {
		self.state = makeInitialState()
		self.makeStateContainer = makeStateContainer
	}
	
	public func dispatch(action: S.Action) {
		subject.dispatch(action)
	}
}
