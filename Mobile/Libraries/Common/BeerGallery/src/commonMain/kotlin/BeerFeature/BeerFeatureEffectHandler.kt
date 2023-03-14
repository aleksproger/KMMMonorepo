package Mobile.BeerGallery

import Multiplatform.Architecture.EffectHandler
import Multiplatform.Architecture.Store
import Multiplatform.DTO.Beer
import Multiplatform.DTO.BeerViewModel
import Multiplatform.Serialization.jsonSerializer
import Multiplatform.ClientNetwork.DefaultRequestBuilder
import Multiplatform.ClientNetwork.DefaultRequestPerformer
import Multiplatform.ClientNetwork.DefaultRequestHeadersFactory
import Multiplatform.ClientNetwork.NetworkFetcher
import Multiplatform.ClientNetwork.DefaultNetworkFetcher


internal class BeerFeatureEffectHandler(
    private val beerFetcher: NetworkFetcher<Unit, List<BeerViewModel>> = DefaultNetworkFetcher<Unit, List<BeerViewModel>>(
        DefaultRequestPerformer<Unit, List<BeerViewModel>>(
            responseMapper = { body ->
                jsonSerializer<List<BeerViewModel>>().deserialize(body)
            },
            requestBuilder = DefaultRequestBuilder<Unit>(
                httpMethod = "GET",
                requestURL = "http://0.0.0.0:8080/beers",
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
