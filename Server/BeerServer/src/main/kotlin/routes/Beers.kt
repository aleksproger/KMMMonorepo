package Server.BeerServer

import Multiplatform.DTO.BeerViewModel
import io.ktor.server.application.*
import io.ktor.http.*
import io.ktor.server.response.*
import io.ktor.server.routing.*


val colorProvider = ImageColorProviderImpl()

fun Route.listBeersRoute() {
    get("/beers") {
        call.respond(
            beerFetcher.perform(Unit).map {
                BeerViewModel(
                    id = it.id,
                    name = it.name,
                    description = it.description,
                    image_url = it.image_url,
                    average_color = colorProvider.provideHex(it.image_url)
                )
            }
        )
    }
}
