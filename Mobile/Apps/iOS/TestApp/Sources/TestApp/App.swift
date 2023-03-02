import SwiftUI
import BeerGallery

@main
struct ImTheApp: App {
	@ObservedObject
	var viewStore = ObservableObjectStore<BeerStore>(.initial, BeerStore.init(initialState:onStateChange:))
	
    var body: some Scene {
		WindowGroup {
			ZStack {
				BeerGalleryView(viewStore: viewStore)
			}.onAppear {
				viewStore.dispatch(action: BeerFeatureAction.ViewActionBeerViewDidAppear())
			}
		}
	}
}
