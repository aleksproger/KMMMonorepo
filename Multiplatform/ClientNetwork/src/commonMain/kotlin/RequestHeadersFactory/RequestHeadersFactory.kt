package Multiplatform.ClientNetwork

interface RequestHeadersFactory {
    fun make(): Map<String, String>
}