import UIKit
import SwiftUI

extension Color {
  func getComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    if let components = cgColor?.components {
      switch components.count {
      case 2:
        return (red: components[0], green: components[0], blue: components[0], alpha: components[1])
      case 4:
        return (red: components[0], green: components[1], blue: components[2], alpha: components[3])
      default:
          break
      }
    }

    return (red: 0, green: 0, blue: 0, alpha: 0)
  }

  func interpolate(to: Color, percentage: CGFloat) -> Color {
    let fromComponents = getComponents()
    let toComponents = to.getComponents()

    let newRed   = (1.0 - percentage) * fromComponents.red   + percentage * toComponents.red
    let newGreen = (1.0 - percentage) * fromComponents.green + percentage * toComponents.green
    let newBlue  = (1.0 - percentage) * fromComponents.blue  + percentage * toComponents.blue
    let newAlpha = (1.0 - percentage) * fromComponents.alpha + percentage * toComponents.alpha

    return Color(red: newRed, green: newGreen, blue: newBlue)
  }
}