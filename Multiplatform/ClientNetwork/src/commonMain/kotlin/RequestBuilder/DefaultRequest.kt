package Multiplatform.ClientNetwork

data class DefaultRequest(
    val httpMethod: String,
    val url: String,
    val headers: Map<String, String>,
    val body: String
)