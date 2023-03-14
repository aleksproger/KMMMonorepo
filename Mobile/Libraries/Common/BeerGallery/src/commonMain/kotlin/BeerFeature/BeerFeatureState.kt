package Mobile.BeerGallery

import Multiplatform.DTO.BeerViewModel

data class BeerFeatureState(
    val loading: Boolean,
    val beers: List<BeerViewModel>,
    val error: Throwable
)