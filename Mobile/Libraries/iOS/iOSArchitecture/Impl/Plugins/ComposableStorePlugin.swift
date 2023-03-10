import iOSArchitectureAPI
import Foundation

public final class ComposableStorePlugin<S: Sequence, P: iOSArchitectureAPI.StorePlugin>: NSObject, iOSArchitectureAPI.StorePlugin
where S.Element == P {
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
}