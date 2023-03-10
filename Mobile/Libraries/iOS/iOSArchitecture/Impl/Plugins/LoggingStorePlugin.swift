import iOSArchitectureAPI
import Foundation

public final class LoggingStorePlugin<S, A>: iOSArchitectureAPI.StorePlugin {
	public typealias State = S
	public typealias Action = A

	public init() {}

	public func onWillDispatch(action: A, state: S) {
		print("Will dispatch \(action) on state \(state)")

	}

    public func onDidDispatch(action: A, state: S) {
		print("Finished dispatch \(action). New state is \(state)")
	}
}