package SharedNetwork

import io.ktor.client.*
import io.ktor.client.request.*

import io.ktor.client.request.*
import io.ktor.client.statement.*

import io.ktor.http.*

import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.call.body
import io.ktor.serialization.kotlinx.json.*
import io.ktor.serialization.*

class DefaultRequestPerformer<Payload, Response> (
    private val responseMapper: (String) -> Response,
    private val requestBuilder: RequestBuilder<Payload, DefaultRequest>
) : RequestPerformer<Payload, Response> {
    override suspend fun perform(request: Payload): Response {
        val client = HttpClient()
        var defaultRequest = requestBuilder.build(request)

        try {
            val httpResponse = client.request({
                method = HttpMethod(defaultRequest.httpMethod)
                setBody(defaultRequest.body)
                url { takeFrom(defaultRequest.url) }
                headers {
                    defaultRequest.headers.forEach { (key, value) ->
                        append(key, value)
                    }
                }
            })
            return responseMapper(httpResponse.body())
        } catch (e: Exception) {
            println("Get request failed: $e")
            throw e
        } finally {
            client.close()
        }
    }
}