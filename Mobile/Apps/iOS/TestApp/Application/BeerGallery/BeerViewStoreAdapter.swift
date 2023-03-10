import BeerGallery
import iOSArchitectureAPI
import iOSArchitectureImpl

class BeerViewStoreAdapter: iOSArchitectureAPI.Store {
	typealias Action = BeerFeatureAction.ViewAction
	typealias State = BeerFeatureState
	
	private let subject: BeerViewStore
	
	init(_ initialState: BeerFeatureState) {
		self.subject = BeerViewStoreImpl(
			initialState: initialState,
			plugin: DefaultStorePluginAdater(
				ComposableStorePlugin([
					LoggingStorePlugin<BeerFeatureState, BeerFeatureAction>()
				])            
			)
		)
	}
	
	func dispatch(_ action: BeerFeatureAction.ViewAction) async -> State {
		try! await subject.dispatch(action: action)
	}
}

extension BeerFeatureState {
	public static let initial = BeerFeatureState(loading: true, beers: [], error: KotlinThrowable())
}

/// TODO: Workaround for 
/// error: argument type 'DefaultStorePluginAdater<ComposableStorePlugin<[LoggingStorePlugin<BeerFeatureState, BeerFeatureAction>], LoggingStorePlugin<BeerFeatureState, BeerFeatureAction>>>'
/// does not conform to expected type 'ArchitectureStorePlugin'
final class DefaultStorePluginAdater<Plugin: iOSArchitectureAPI.StorePlugin>: NSObject, ArchitectureStorePlugin {
    private let subject: Plugin

    init(_ subject: Plugin) {
        self.subject = subject
    }

    func onWillDispatch(action: Any?, state: Any?) {
        guard let action = action as? Plugin.Action,
			let state = state as? Plugin.State else {
			fatalError("Cannot cast and states to the correct types.")
		}

        subject.onWillDispatch(action: action, state: state)
    }
    
    func onDidDispatch(action: Any?, state: Any?) {
        guard let action = action as? Plugin.Action,
            let state = state as? Plugin.State else {
            fatalError("Cannot cast actions and states to the correct types.")
        }

        subject.onDidDispatch(action: action, state: state)
    }
}
