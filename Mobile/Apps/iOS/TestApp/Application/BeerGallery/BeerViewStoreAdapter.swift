import BeerGallery
import iOSArchitectureAPI
import iOSArchitectureImpl
import iOSAppUtilities

class BeerViewStoreAdapter: iOSArchitectureAPI.Store {
	typealias Action = BeerFeatureAction.ViewAction
	typealias State = BeerFeatureState
	typealias Effect = BeerFeatureEffect
	
	private let subject: BeerViewStore
	
	init(_ initialState: BeerFeatureState) {
		self.subject = BeerViewStoreImpl(
			initialState: initialState,
			plugin: DefaultStorePluginAdater(
				ComposableStorePlugin([
					LoggingStorePlugin<State, BeerFeatureAction, Effect>().asAny(),
					OSSignpostPlugin<State, BeerFeatureAction, Effect>().asAny()
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
private final class DefaultStorePluginAdater<Plugin: iOSArchitectureAPI.StorePlugin>: ArchitectureStorePlugin {
    private let subject: Plugin

    init(_ subject: Plugin) {
        self.subject = subject
    }

    func onWillDispatch(action: Any?, state: Any?) {
        guard let action = action as? Plugin.Action,
			let state = state as? Plugin.State else {
			fatalError("Cannot cast actions and states to the correct types.")
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

	func onWillReduce(action: Any?, state: Any?) {
		guard let action = action as? Plugin.Action,
            let state = state as? Plugin.State else {
            fatalError("Cannot cast actions and states to the correct types.")
        }

        subject.onWillReduce(action: action, state: state)
	}

    func onDidReduce(action: Any?, state: Any?) {
		guard let action = action as? Plugin.Action,
            let state = state as? Plugin.State else {
            fatalError("Cannot cast actions and states to the correct types.")
        }

        subject.onDidReduce(action: action, state: state)
	}

    func onWillHandleEffect(effect: Any?) {
		guard let effect = effect as? Plugin.Effect else {
            fatalError("Cannot cast effect to the correct type.")
        }

        subject.onWillHandleEffect(effect: effect)
	}

    func onDidHandleEffect(effect: Any?) {
		guard let effect = effect as? Plugin.Effect else {
            fatalError("Cannot cast effect to the correct type.")
        }

        subject.onDidHandleEffect(effect: effect)
	}
}
