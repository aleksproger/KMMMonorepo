package Mobile.BeerGallery

import SharedNetwork.*

class DefaultNetworkFetcher<Payload, Response>(
    private val requestPerformer: NonSuspendRequestPerformer<Payload, Response>
) : NetworkFetcher<Payload, Response> {
    constructor(suspendingRequestPerformer: RequestPerformer<Payload, Response>) : this(NonSuspendRequestPerformerImpl(suspendingRequestPerformer))

    override fun fetch(
        payload: Payload,
        onSuccess: (Response) -> Unit,
        onFailure: (Throwable) -> Unit
    ) {
        requestPerformer.set { response ->
            response.fold(
                onSuccess = onSuccess,
                onFailure = onFailure
            )
        }
        requestPerformer.perform(payload)
    }

}