package SharedNetwork

interface ResponseMapper<Response, MappedResponse> {
    fun map(response: Response): MappedResponse
}   