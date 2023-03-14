package Multiplatform.DTO

import kotlinx.serialization.Serializable

@Serializable
data class BeerViewModel(
    val id: Int,
    val name: String,
    val description: String,
    val image_url: String,
    val average_color: String
)