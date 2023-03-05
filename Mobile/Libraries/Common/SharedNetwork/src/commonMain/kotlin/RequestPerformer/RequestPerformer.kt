package SharedNetwork

interface RequestPerformer<in Request, Response> {
    suspend fun perform(request: Request): Response
}

// abstract class RequestPerformer<in Request, Response> {
//     inline suspend fun perform(request: Request): Response {
//         throw NotImplementedError("perform(request: Request) is not implemented yet")
//     }
// }