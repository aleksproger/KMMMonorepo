package Mobile.BeerGallery

import Multiplatform.DTO.BeerViewModel

sealed class BeerFeatureAction {
    sealed class ViewAction: BeerFeatureAction() {
        class BeerViewDidAppear() : ViewAction()
    }

    internal sealed class LocalAction: BeerFeatureAction() {
        class LoadBeers() : LocalAction()
        data class HandleBeersSuccess(val beers: List<BeerViewModel>) : LocalAction()
        data class HandleBeersFailure(val error: Throwable) : LocalAction()
    }
}
