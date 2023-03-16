package Multiplatform.ClientNetwork

data class URLRequest<T>(
    val url: String,
    val payload: T
)