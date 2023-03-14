package Server.BeerServer

interface ImageColorProvider {
    suspend fun provideHex(imageURL: String): String
}