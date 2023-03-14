package Server.BeerServer

import java.awt.Color
import java.awt.image.BufferedImage
import javax.imageio.ImageIO

//TODO: Move to Multiplatform/Utilities package
internal fun calculateAverageColor(imageBytes: ByteArray): String {
    val image = ImageIO.read(imageBytes.inputStream())
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    var pixelCount = 0

    for (x in 0 until image.width) {
        for (y in 0 until image.height) {
            val pixel = Color(image.getRGB(x, y))
            totalRed += pixel.red
            totalGreen += pixel.green
            totalBlue += pixel.blue
            pixelCount++
        }
    }

    val averageRed = totalRed / pixelCount
    val averageGreen = totalGreen / pixelCount
    val averageBlue = totalBlue / pixelCount

    val rgbColor = Color(averageRed, averageGreen, averageBlue).rgb
    return String.format("#%06X", 0xFFFFFF and rgbColor)
}
