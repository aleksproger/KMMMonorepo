package Server.BeerServer

import Multiplatform.ClientNetwork.DefaultRequestPerformer
import Multiplatform.ClientNetwork.DefaultRequestBuilder
import Multiplatform.ClientNetwork.DefaultRequestHeadersFactory
import Multiplatform.DTO.Beer
import Multiplatform.Serialization.jsonSerializer


val beerFetcher = DefaultRequestPerformer<Unit, List<Beer>>(
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

