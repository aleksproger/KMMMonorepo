package Multiplatform.Storage

interface Storage<Key, Value> {
    fun set(key: Key, value: Value)
    fun get(key: Key): Value?
}