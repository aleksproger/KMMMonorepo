package Mobile.BeerGallery

import Multiplatform.DTO.Beer

sealed class BeerFeatureAction {
    sealed class ViewAction: BeerFeatureAction() {
        class BeerViewDidAppear() : ViewAction()
    }

    internal sealed class LocalAction: BeerFeatureAction() {
        class LoadBeers() : LocalAction()
        data class HandleBeersSuccess(val beers: List<Beer>) : LocalAction()
        data class HandleBeersFailure(val error: Throwable) : LocalAction()
    }
}
