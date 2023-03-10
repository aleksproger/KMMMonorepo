import iOSArchitectureAPI
import Foundation

public final class ComposableStorePlugin<S: Sequence, P: iOSArchitectureAPI.StorePlugin>: NSObject, iOSArchitectureAPI.StorePlugin
where S.Element == P {
    public typealias State = P.State
    public typealias Action = P.Action
    public typealias Effect = P.Effect

    private let plugins: S

    public init(_ plugins: S) {
        self.plugins = plugins
    }

   public  func onWillDispatch(action: P.Action, state: P.State) {
		for plugin in plugins {
            plugin.onWillDispatch(action: action, state: state)
        }

	}
    public func onDidDispatch(action: P.Action, state: P.State) {
		for plugin in plugins {
            plugin.onDidDispatch(action: action, state: state)
        }
	}

    public func onWillReduce(action: Action, state: State) {
        for plugin in plugins {
            plugin.onWillReduce(action: action, state: state)
        }
	}

    public func onDidReduce(action: Action, state: State) {
        for plugin in plugins {
            plugin.onDidReduce(action: action, state: state)
        }
	}

    public func onWillHandleEffect(effect: Effect) {
        for plugin in plugins {
            plugin.onWillHandleEffect(effect: effect)
        }
	}

    public func onDidHandleEffect(effect: Effect) {
        for plugin in plugins {
            plugin.onDidHandleEffect(effect: effect)
        }
	}
}