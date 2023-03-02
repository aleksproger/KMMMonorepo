package SharedNetwork

class DefaultRequestHeadersFactory : RequestHeadersFactory {
    override fun make(): Map<String, String> {
        return mapOf(
            "Content-Type" to "application/json",
            "Accept" to "application/json"
        )
    }
}