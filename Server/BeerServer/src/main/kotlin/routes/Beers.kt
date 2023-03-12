package Server.BeerServer

import Multiplatform.ClientNetwork.*
import Multiplatform.Serialization.*
import Multiplatform.DTO.Beer
import io.ktor.server.application.*
import io.ktor.http.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Route.listBeersRoute() {
    get("/beers") {
        call.respond(
            beerFetcher.perform(Unit)
        )
    }
}

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