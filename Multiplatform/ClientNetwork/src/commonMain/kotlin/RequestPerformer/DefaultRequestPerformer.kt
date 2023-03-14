package Multiplatform.ClientNetwork

import io.ktor.client.*
import io.ktor.client.request.*

import io.ktor.client.request.*
import io.ktor.client.statement.*

import io.ktor.http.*

import io.ktor.client.call.body
import io.ktor.client.plugins.cache.*
import io.ktor.client.plugins.logging.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.serialization.*

class DefaultRequestPerformer<Payload, Response> (
    private val responseMapper: (String) -> Response,
    private val requestBuilder: RequestBuilder<Payload, DefaultRequest>
) : RequestPerformer<Payload, Response> {
    override suspend fun perform(request: Payload): Response {
        val client = HttpClient() {
            install(HttpCache)
        }
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

suspend fun downloadImage(url: String): ByteArray {
    val httpClient = HttpClient()
    val response = httpClient.get(url).readBytes()
    httpClient.close()
    return response
}

// fun calculateAverageColor(bitmap: Bitmap): Int {
//     var totalRed = 0
//     var totalGreen = 0
//     var totalBlue = 0
//     var pixelCount = 0

//     for (x in 0 until bitmap.width) {
//         for (y in 0 until bitmap.height) {
//             val pixel = bitmap.getPixel(x, y)
//             totalRed += Color.red(pixel)
//             totalGreen += Color.green(pixel)
//             totalBlue += Color.blue(pixel)
//             pixelCount++
//         }
//     }

//     val averageRed = totalRed / pixelCount
//     val averageGreen = totalGreen / pixelCount
//     val averageBlue = totalBlue / pixelCount

//     return Color.rgb(averageRed, averageGreen, averageBlue)
// }

// interface URLRequestPerformer <Payload, Response> {
//     suspend fun perform(request: URLRequest<Payload>): Response
// }: RequestPerformer<URLRequest<Payload>, Response>

// class URLRequestPerformerImpl<Payload, Intermediate, Response> (
//     private val responseMapper: (Intermediate) -> Response,
//     private val requestBuilder: RequestBuilder<URLRequest<Payload>, DefaultRequest>
// ) : URLRequestPerformer<Payload, Response> {
//     override suspend fun perform(request: URLRequest<Payload>): Response {
//         val client = HttpClient() {
//             install(HttpCache)
//         }
//         var defaultRequest = requestBuilder.build(request)

//         try {
//             val httpResponse = client.request({
//                 method = HttpMethod(defaultRequest.httpMethod)
//                 setBody(defaultRequest.body)
//                 url { takeFrom(defaultRequest.url) }
//                 headers {
//                     defaultRequest.headers.forEach { (key, value) ->
//                         append(key, value)
//                     }
//                 }
//             })
//             return responseMapper(httpResponse.body())
//         } catch (e: Exception) {
//             println("Get request failed: $e")
//             throw e
//         } finally {
//             client.close()
//         }
//     }
// }

// data class URLRequest<T>(
//     val url: String
//     var payload: T
// )

