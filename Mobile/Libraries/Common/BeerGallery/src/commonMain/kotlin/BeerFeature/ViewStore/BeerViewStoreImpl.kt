package Mobile.BeerGallery

import Multiplatform.Architecture.Store
import Multiplatform.Architecture.DefaultStore
import Multiplatform.Architecture.StorePlugin
import Multiplatform.Architecture.EmptyStorePlugin

class BeerViewStoreImpl(
    private val subject: Store<BeerFeatureState, BeerFeatureAction>
) : Store<BeerFeatureState, BeerFeatureAction.ViewAction>, BeerViewStore {
    constructor(initialState: BeerFeatureState): this(
        DefaultStore(
            state = initialState,
            reducer = BeerFeatureReducer(),
            effectHandler = BeerFeatureEffectHandler(),
            plugin = EmptyStorePlugin()
        )
    )

    constructor(
        initialState: BeerFeatureState,
        plugin: StorePlugin<BeerFeatureState, BeerFeatureAction>
    ): this(
        DefaultStore(
            state = initialState,
            reducer = BeerFeatureReducer(),
            effectHandler = BeerFeatureEffectHandler(),
            plugin = plugin
        )
    )

    override suspend fun dispatch(action: BeerFeatureAction.ViewAction): BeerFeatureState {
        return subject.dispatch(action)
    }
}