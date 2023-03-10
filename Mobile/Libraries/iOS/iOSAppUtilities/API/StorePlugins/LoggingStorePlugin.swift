import iOSArchitectureAPI
import Foundation

public final class LoggingStorePlugin<S, A, E>: iOSArchitectureAPI.StorePlugin {
	public typealias State = S
	public typealias Action = A
	public typealias Effect = E

	public init() {}

	public func onWillDispatch(action: A, state: S) {
		print("Will dispatch \(action)")
	}
	
    public func onDidDispatch(action: A, state: S) {
		print("Finished dispatch \(action). New state is \(state)")
	}

	public func onWillReduce(action: A, state: S) {
		print("Will reduce \(action)")
	}

    public func onDidReduce(action: A, state: S) {
		print("Finished reduce \(action)")
	}

    public func onWillHandleEffect(effect: E) {
		print("Will handle effect \(effect)")
	}

    public func onDidHandleEffect(effect: E) {
		print("Did handle effect \(effect)")
	}
}