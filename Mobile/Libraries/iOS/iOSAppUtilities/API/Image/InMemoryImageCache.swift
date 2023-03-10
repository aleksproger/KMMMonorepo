import Foundation
import SwiftUI

import iOSStorage
import iOSUI

public final class InMemoryImageCache: KeyValueStorage {
    public static let shared = InMemoryImageCache()

    private let nsCache = NSCache<NSURL, NSCacheAdapter<Image>>()

    private init() {}

    public func get(key: URL) -> Image? {
        nsCache[key]
    }

    public func set(key: URL, value: Image) {
        nsCache[key] = value
    }
}

extension NSCache where KeyType == NSURL, ObjectType == NSCacheAdapter<Image> {
    subscript(aKey: URL) -> Image? {
        get { object(forKey: aKey as NSURL)?.value }

        set {
            if let value = newValue {
                setObject(NSCacheAdapter(value: value), forKey: aKey as NSURL)
            } else {
                removeObject(forKey: aKey as NSURL)
            }
        }
    }
}