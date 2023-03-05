package SharedNetwork

interface ResponseHandler<Response> {
    fun handle(response: Response)
}

