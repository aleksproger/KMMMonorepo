package Mobile.BeerGallery

import Multiplatform.DTO.Beer

sealed class BeerFeatureEffect {
    class LoadBeersFromAPI() : BeerFeatureEffect()
    class EmptyEffect() : BeerFeatureEffect()
}