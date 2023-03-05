import BeerGallery
import SwiftUI

extension DTOBeer {
    var url: URL {
        return URL(string: image_url)!
    }
}

extension DTOBeer: Identifiable {}
