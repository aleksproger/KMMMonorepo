package Multiplatform.ClientNetwork

import io.ktor.client.request.*
import io.ktor.http.*

class URLRequestBuilder<Payload>(
    val httpMethod: String,
    val headersFactory: RequestHeadersFactory,
    val serialize: (Payload) -> String
) : RequestBuilder<URLRequest<Payload>, DefaultRequest> {
    override fun build(request: URLRequest<Payload>): DefaultRequest {
        return DefaultRequest(
            httpMethod = httpMethod,
            url = request.url,
            headers = headersFactory.make(),
            body = serialize(request.payload)
        )
    }
}