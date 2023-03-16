package Multiplatform.ClientNetwork

import io.ktor.client.request.*

interface RequestBuilder<in Request, RequestData> {
    fun build(request: Request): RequestData
}