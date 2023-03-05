package SharedNetwork

import io.ktor.client.request.*
import io.ktor.http.*

class DefaultRequestBuilder<Payload>(
    val httpMethod: String,
    val requestURL: String,
    val headersFactory: RequestHeadersFactory,
    val serialize: (Payload) -> String
) : RequestBuilder<Payload, DefaultRequest> {
    override fun build(payload: Payload): DefaultRequest {
        return DefaultRequest(
            httpMethod = httpMethod,
            url = requestURL,
            headers = headersFactory.make(),
            body = serialize(payload)
        )
    }
}