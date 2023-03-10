package Multiplatform.Storage

class DictionaryStorage<Key, Value>(
    private val map: MutableMap<Key, Value> = mutableMapOf<Key, Value>()
): Storage<Key, Value> {
    override fun set(key: Key, value: Value) {
        map.put(key, value)
    }

    override fun get(key: Key): Value? {
        return map.get(key)
    }
}