package Mobile.BeerGallery

interface BeerViewStore {
    suspend fun dispatch(action: BeerFeatureAction.ViewAction): BeerFeatureState
}

