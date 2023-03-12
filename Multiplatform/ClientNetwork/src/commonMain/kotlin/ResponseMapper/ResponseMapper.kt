package Multiplatform.ClientNetwork

interface ResponseMapper<Response, MappedResponse> {
    fun map(response: Response): MappedResponse
}   