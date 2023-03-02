package Mobile.BeerGallery

interface NetworkFetcher<Payload, Response> {
    fun fetch(
        payload: Payload,
        onSuccess: (Response) -> Unit,
        onFailure: (Throwable) -> Unit
    )
}