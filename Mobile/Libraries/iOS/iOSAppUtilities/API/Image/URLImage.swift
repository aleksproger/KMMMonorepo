import Foundation
import SwiftUI

import iOSStorage
import iOSUI

public struct URLImage<C: View, P: View, S: KeyValueStorage>: ExternalImage 
where S.Key == URL, S.Value == Image 
{
    private let url: URL
    private let storage: S
    private let placeholder: () -> P
    private let transform: (Image) -> C

    public init(
        _ url: URL,
        _ storage: S,
        _ placeholder: @autoclosure @escaping () -> P,
        _ transform: @escaping (Image) -> C
    ) {
        self.url = url
        self.storage = storage
        self.placeholder = placeholder
        self.transform = { image in
            storage.set(key: url, value: image)
            return transform(image)
        }
    }
    
    public var body: some View {
        if let cachedImage = storage.get(key: url) {
            transform(cachedImage)
        } else {
            AsyncImage(url: url, content: transform, placeholder: placeholder)
        }
    }
}