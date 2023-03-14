package Mobile.BeerGallery

import Multiplatform.Architecture.Reducer
import Multiplatform.DTO.BeerViewModel

internal class BeerFeatureReducer : Reducer<BeerFeatureState, BeerFeatureAction, BeerFeatureEffect> {
    override suspend fun reduce(state: BeerFeatureState, action: BeerFeatureAction): Pair<BeerFeatureState, BeerFeatureEffect> {
        return when (action) {
            is BeerFeatureAction.LocalAction.LoadBeers -> {
                Pair(state.copy(loading = true), BeerFeatureEffect.LoadBeersFromAPI())
            }
            is BeerFeatureAction.LocalAction.HandleBeersSuccess -> {
                Pair(state.copy(loading = false, beers = action.beers), BeerFeatureEffect.EmptyEffect())
            }
            is BeerFeatureAction.LocalAction.HandleBeersFailure -> {
                Pair(state.copy(loading = false, error = action.error), BeerFeatureEffect.EmptyEffect())
            }
            is BeerFeatureAction.ViewAction.BeerViewDidAppear -> {
                Pair(state.copy(), BeerFeatureEffect.LoadBeersFromAPI())
            }
        }
    }
}