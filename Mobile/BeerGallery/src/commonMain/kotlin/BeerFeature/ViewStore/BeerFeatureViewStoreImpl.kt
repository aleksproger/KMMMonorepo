package Mobile.BeerGallery

import Multiplatform.Architecture.Store
import Multiplatform.Architecture.DefaultStore

class BeerFeatureViewStoreImpl(
    private val subject: Store<BeerFeatureState, BeerFeatureAction>
) : Store<BeerFeatureState, BeerFeatureAction.ViewAction>, BeerFeatureViewStore {
    constructor(initialState: BeerFeatureState, onStateChange: (BeerFeatureState) -> Unit): this(
        DefaultStore(
            state = initialState,
            onStateChange = onStateChange,
            reducer = BeerFeatureReducer(),
            effectHandler = BeerFeatureEffectHandler()
        )
    )

    override fun dispatch(action: BeerFeatureAction.ViewAction) {
        subject.dispatch(action)
    }
}