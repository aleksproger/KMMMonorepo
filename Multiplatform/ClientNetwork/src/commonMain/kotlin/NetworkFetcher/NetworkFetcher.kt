package Multiplatform.ClientNetwork

interface NetworkFetcher<Payload, Response> {
    suspend fun fetch(payload: Payload): Result<Response>
}