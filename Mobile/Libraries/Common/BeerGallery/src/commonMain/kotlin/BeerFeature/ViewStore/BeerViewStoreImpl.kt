package Mobile.BeerGallery

import Multiplatform.Architecture.Store
import Multiplatform.Architecture.DefaultStore

class BeerViewStoreImpl(
    private val subject: Store<BeerFeatureState, BeerFeatureAction>
) : Store<BeerFeatureState, BeerFeatureAction.ViewAction>, BeerViewStore {
    constructor(initialState: BeerFeatureState): this(
        DefaultStore(
            state = initialState,
            reducer = BeerFeatureReducer(),
            effectHandler = BeerFeatureEffectHandler()
        )
    )

    override suspend fun dispatch(action: BeerFeatureAction.ViewAction): BeerFeatureState {
        return subject.dispatch(action)
    }
}