package SharedNetwork

interface RequestHeadersFactory {
    fun make(): Map<String, String>
}