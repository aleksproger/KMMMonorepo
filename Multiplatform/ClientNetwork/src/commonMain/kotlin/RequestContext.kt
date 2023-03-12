package Multiplatform.ClientNetwork

data class RequestContext<T>(
    val path: String?,
    val payload: T
)