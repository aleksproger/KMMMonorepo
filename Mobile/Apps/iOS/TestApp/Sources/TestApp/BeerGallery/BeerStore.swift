import BeerGallery
import iOSArchitecture

class BeerStore: Store {
	typealias Action = BeerFeatureAction.ViewAction
	typealias State = BeerFeatureState
	
	private let subject: BeerFeatureViewStore
	
	init(
		initialState: BeerFeatureState,
		onStateChange: @escaping (BeerFeatureState)-> Void
	) {
		self.subject = BeerFeatureViewStoreImpl(
			initialState: initialState,
			onStateChange: onStateChange
		)
	}
	
	func dispatch(_ action: BeerFeatureAction.ViewAction) {
		subject.dispatch(action: action)
	}
}
