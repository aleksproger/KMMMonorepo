import SwiftUI
import BeerGallery
import iOSArchitectureAPI

@main
@MainActor
struct ImTheApp: App {
	@ObservedObject
	var viewStore = ObservableObjectStore<BeerViewStoreAdapter>(.initial, BeerViewStoreAdapter.init)
	
    var body: some Scene {
		WindowGroup {
			ZStack {
				BeerGalleryView(viewStore: viewStore)
			}.task {
				await viewStore.dispatch(action: BeerFeatureAction.ViewActionBeerViewDidAppear())
			}
		}
	}
}
