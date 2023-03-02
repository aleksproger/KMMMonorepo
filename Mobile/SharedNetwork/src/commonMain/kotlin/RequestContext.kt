package SharedNetwork

data class RequestContext<T>(
    val path: String?,
    val payload: T
)