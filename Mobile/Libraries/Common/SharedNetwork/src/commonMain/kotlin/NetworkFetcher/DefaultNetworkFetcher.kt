package SharedNetwork

class DefaultNetworkFetcher<Payload, Response>(
    private val requestPerformer: RequestPerformer<Payload, Response>
) : NetworkFetcher<Payload, Response> {
    override suspend fun fetch(payload: Payload): Result<Response> {
        return runCatching { requestPerformer.perform(payload) }
    }
}