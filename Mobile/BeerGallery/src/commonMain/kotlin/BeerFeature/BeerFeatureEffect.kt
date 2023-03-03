package Mobile.BeerGallery

import Multiplatform.DTO.Beer

internal sealed class BeerFeatureEffect {
    class LoadBeersFromAPI() : BeerFeatureEffect()
    class EmptyEffect() : BeerFeatureEffect()
}