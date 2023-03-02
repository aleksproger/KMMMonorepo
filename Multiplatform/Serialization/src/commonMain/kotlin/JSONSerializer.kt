package Multiplatform.Serialization

import kotlinx.serialization.json.Json
import kotlinx.serialization.Serializable
import kotlinx.serialization.KSerializer

import kotlinx.serialization.serializer

@OptIn(kotlinx.serialization.InternalSerializationApi::class)
class DefaultJSONSerializer<T>(private val serializer: KSerializer<T>) : Serializer<T> {
    override fun serialize(obj: T) : String {
        val json = Json {
            ignoreUnknownKeys = true
        }
        return json.encodeToString(serializer, obj)
    }

    override fun deserialize(jsonString: String): T {
        val json = Json {
            ignoreUnknownKeys = true
        }
        return json.decodeFromString(serializer, jsonString)
    }
}

@OptIn(kotlinx.serialization.InternalSerializationApi::class)
inline fun <reified T> jsonSerializer(): Serializer<T> {
    return DefaultJSONSerializer(serializer<T>())
}

