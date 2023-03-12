package Multiplatform.ClientNetwork

interface ResponseHandler<Response> {
    fun handle(response: Response)
}

