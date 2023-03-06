import BeerGallery
import iOSArchitecture

class BeerViewStoreAdapter: Store {
	typealias Action = BeerFeatureAction.ViewAction
	typealias State = BeerFeatureState
	
	private let subject: BeerViewStore
	
	init(_ initialState: BeerFeatureState) {
		self.subject = BeerViewStoreImpl(initialState: initialState)
	}
	
	func dispatch(_ action: BeerFeatureAction.ViewAction) async -> State {
		try! await subject.dispatch(action: action)
	}
}

extension BeerFeatureState {
	public static let initial = BeerFeatureState(loading: true, beers: [], error: KotlinThrowable())
}