package SharedNetwork

interface NonSuspendRequestPerformer<in Request, Response> {
    fun perform(request: Request)
    fun set(handler: (Result<Response>) -> Unit)
}

