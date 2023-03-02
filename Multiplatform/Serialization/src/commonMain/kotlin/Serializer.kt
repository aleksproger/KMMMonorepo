package Multiplatform.Serialization

interface Serializer<T> {
    fun serialize(obj: T): String
    fun deserialize(jsonString: String): T
}