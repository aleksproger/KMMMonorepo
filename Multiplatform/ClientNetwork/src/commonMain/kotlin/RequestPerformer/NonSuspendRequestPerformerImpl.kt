package Multiplatform.ClientNetwork

import io.ktor.client.*
import io.ktor.client.request.*

import io.ktor.client.request.*
import io.ktor.client.statement.* 

import kotlinx.coroutines.*

class NonSuspendRequestPerformerImpl<Payload, Response> (
    private val requestPerformer: RequestPerformer<Payload, Response>,
    private var responseHandler: (Result<Response>) -> Unit = {}
) : NonSuspendRequestPerformer<Payload, Response> {

    override fun perform(request: Payload) {
        GlobalScope.launch {
            val result = runCatching { requestPerformer.perform(request) }
            responseHandler.invoke(result)
        }
    }

    override fun set(handler: (Result<Response>) -> Unit) {
        responseHandler = handler
    }
}
