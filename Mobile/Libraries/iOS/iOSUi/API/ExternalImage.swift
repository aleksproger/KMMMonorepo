import Foundation
import SwiftUI
import iOSStorage

public protocol ExternalImage: View {
    associatedtype Placeholder: View
    associatedtype Content: View
    associatedtype Storage: KeyValueStorage where Storage.Value == Image

    init(
        _ identifier: Storage.Key,
        _ storage: Storage,
        _ placeholder: @autoclosure @escaping () -> Placeholder,
        _ transform: @escaping (Image) -> Content
    )
}
