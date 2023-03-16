package Server.BeerServer

import Multiplatform.Storage.Storage
import Multiplatform.Storage.InMemoryStorage
import Multiplatform.ClientNetwork.RequestPerformer
import Multiplatform.ClientNetwork.ByteArrayRequestPerformer
import Multiplatform.ClientNetwork.DefaultRequestHeadersFactory
import Multiplatform.ClientNetwork.URLRequestBuilder
import Multiplatform.ClientNetwork.URLRequest
import Server.BeerStorage.BeerImageStorage

class ImageColorProviderImpl(
    private val storage: Storage<String, String> = BeerImageStorage(),
    private val imageCalculator: ImageColorCalculator = DefaultImageColorCalculator(),
    private val requestPerformer: RequestPerformer<URLRequest<Unit>, ByteArray> = ByteArrayRequestPerformer(
        responseMapper = { it },
        requestBuilder = URLRequestBuilder<Unit>(
            httpMethod = "GET",
            headersFactory = DefaultRequestHeadersFactory(),
            serialize = { "" }
        )
    )
): ImageColorProvider {
    override suspend fun provideHex(imageURL: String): String {
        val cachedColor = storage.get(imageURL)

        if (cachedColor == null) {
            val imageBytes = requestPerformer.perform(URLRequest(imageURL, Unit))
            val color = imageCalculator.calculateColor(imageBytes)
            storage.set(imageURL, color)
            return color
        }

        return cachedColor
    }
}