package Mobile.BeerGallery

import Multiplatform.DTO.Beer

data class BeerFeatureState(
    val loading: Boolean,
    val beers: List<Beer>,
    val error: Throwable
)