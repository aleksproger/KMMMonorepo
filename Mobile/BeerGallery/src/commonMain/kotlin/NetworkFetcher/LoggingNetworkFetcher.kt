package Mobile.BeerGallery

import SharedNetwork.*

internal class LoggingNetworkFetcher<Payload, Response>(
    private val subject: NetworkFetcher<Payload, Response>
) : NetworkFetcher<Payload, Response> {
    override fun fetch(
        payload: Payload,
        onSuccess: (Response) -> Unit,
        onFailure: (Throwable) -> Unit,
    ) {
        subject.fetch(
            payload,
            onSuccess = {
                println("Success: $it") 
                onSuccess(it)
            },
            onFailure = {
                println("Failure: $it")
                onFailure(it)
            }
        )
    }
}