package Mobile.BeerGallery

internal interface NetworkFetcher<Payload, Response> {
    fun fetch(
        payload: Payload,
        onSuccess: (Response) -> Unit,
        onFailure: (Throwable) -> Unit
    )
}