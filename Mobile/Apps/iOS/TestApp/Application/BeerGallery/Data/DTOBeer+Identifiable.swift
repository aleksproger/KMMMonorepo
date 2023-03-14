import BeerGallery
import SwiftUI

extension DTOBeerViewModel {
    var url: URL {
        return URL(string: image_url)!
    }
}

extension DTOBeerViewModel: Identifiable {}
