package SharedNetwork

interface RequestPerformer<in Request, Response> {
    suspend fun perform(request: Request): Response
}
