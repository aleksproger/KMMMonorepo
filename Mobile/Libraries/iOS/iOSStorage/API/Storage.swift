import Foundation

public protocol KeyValueStorage {
    associatedtype Key
    associatedtype Value

    func set(key: Key, value: Value)
    func get(key: Key) -> Value?
}