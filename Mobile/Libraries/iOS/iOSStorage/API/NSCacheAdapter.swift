import Storage
import SwiftUI

public final class NSCacheAdapter<Value> {
    public let value: Value

    public init(value: Value) {
        self.value = value
    }
}