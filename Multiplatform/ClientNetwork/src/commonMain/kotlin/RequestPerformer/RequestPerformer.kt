package Multiplatform.ClientNetwork

interface RequestPerformer<in Request, Response> {
    suspend fun perform(request: Request): Response
}
