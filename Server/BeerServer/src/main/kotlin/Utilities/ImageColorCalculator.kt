package Server.BeerServer

interface ImageColorCalculator {
    fun calculateColor(imageBytes: ByteArray): String
}