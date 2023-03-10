package Multiplatform.Storage

class LRUCache<Key, Value>(
    private val underlyingStorage: Storage<Key, Value>
): Storage<Key, Value> {
    override fun set(key: Key, value: Value) {
        underlyingStorage.set(key, value)
    }

    override fun get(key: Key): Value? {
        return underlyingStorage.get(key)
    }
}