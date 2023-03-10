package Mobile.BeerGallery

import Multiplatform.Architecture.EffectHandler
import Multiplatform.Architecture.Store
import Multiplatform.DTO.Beer
import Multiplatform.Serialization.jsonSerializer
import SharedNetwork.DefaultRequestBuilder
import SharedNetwork.DefaultRequestPerformer
import SharedNetwork.DefaultRequestHeadersFactory
import SharedNetwork.NetworkFetcher
import SharedNetwork.DefaultNetworkFetcher


internal class BeerFeatureEffectHandler(
    private val beerFetcher: NetworkFetcher<Unit, List<Beer>> = DefaultNetworkFetcher<Unit, List<Beer>>(
        DefaultRequestPerformer<Unit, List<Beer>>(
            responseMapper = { body ->
                jsonSerializer<List<Beer>>().deserialize(body)
            },
            requestBuilder = DefaultRequestBuilder<Unit>(
                httpMethod = "GET",
                requestURL = "https://api.punkapi.com/v2/beers",
                headersFactory = DefaultRequestHeadersFactory(),
                serialize = { "" }
            )
        )
    )
) : EffectHandler<BeerFeatureState, BeerFeatureAction, BeerFeatureEffect> {
    override suspend fun handle(effect: BeerFeatureEffect, store: Store<BeerFeatureState, BeerFeatureAction, BeerFeatureEffect>) {
        when (effect) {
            is BeerFeatureEffect.LoadBeersFromAPI -> {
                beerFetcher.fetch(Unit).fold(
                    onSuccess = { value ->
                        store.dispatch(BeerFeatureAction.LocalAction.HandleBeersSuccess(value))
                    },
                    onFailure = { error ->
                        store.dispatch(BeerFeatureAction.LocalAction.HandleBeersFailure(error))}
                )
            }
            is BeerFeatureEffect.EmptyEffect -> {}
        }
    }
}
