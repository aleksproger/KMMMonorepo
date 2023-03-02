package Mobile.BeerGallery

import Multiplatform.Architecture.EffectHandler
import Multiplatform.Architecture.Store
import Multiplatform.DTO.Beer
import Multiplatform.Serialization.jsonSerializer
import SharedNetwork.DefaultRequestBuilder
import SharedNetwork.DefaultRequestPerformer
import SharedNetwork.DefaultRequestHeadersFactory

class BeerFeatureEffectHandler(
    private val beerFetcher: NetworkFetcher<Unit, List<Beer>> = LoggingNetworkFetcher(
        DefaultNetworkFetcher<Unit, List<Beer>>(
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
    )
) : EffectHandler<BeerFeatureState, BeerFeatureAction, BeerFeatureEffect> {
    override fun handle(effect: BeerFeatureEffect, store: Store<BeerFeatureState, BeerFeatureAction>) {
        when (effect) {
            is BeerFeatureEffect.LoadBeersFromAPI -> {
                beerFetcher.fetch(
                    payload = Unit,
                    onSuccess = { beers ->
                        store.dispatch(BeerFeatureAction.LocalAction.HandleBeersSuccess(beers))
                    },
                    onFailure = { error ->
                        store.dispatch(BeerFeatureAction.LocalAction.HandleBeersFailure(error))
                    }
                )
            }
            is BeerFeatureEffect.EmptyEffect -> {}
        }
    }
}