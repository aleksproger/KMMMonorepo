package Server.BeerServer

import Multiplatform.Storage.Storage
import Multiplatform.Storage.InMemoryStorage
import Multiplatform.ClientNetwork.downloadImage
import Server.BeerStorage.imageStorage

class ImageColorProviderImpl(
    private val storage: Storage<String, String> = imageStorage()
): ImageColorProvider {
    override suspend fun provideHex(imageURL: String): String {
        val cachedColor = storage.get(imageURL)

        if (cachedColor == null) {
            val imageBytes = downloadImage(imageURL)
            val color = calculateAverageColor(imageBytes)
            storage.set(imageURL, color)
            return color
        }

        return cachedColor
    }
}