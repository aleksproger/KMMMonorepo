import SwiftUI
import UIKit

class BackgroundCalculator: ObservableObject {
  @Published
  var color = Color.clear

  var width: CGFloat = 0
  var colors: [Color] = [] {
    didSet {
      color = colors.count > 0 ? colors[0] : Color.clear
    }
  }

  func calucateBackground(position: CGFloat) {
    guard width > 0, colors.count > 0 else {
      return
    }

    let fractionalPage = position / width
    let page = Int(fractionalPage)
    let fromColor: Color = colors[page]

    if fractionalPage > 0 && fractionalPage < CGFloat(colors.count - 1) {
      let nextPage = min(page + 1, colors.count - 1)
      let transitionPercentage = fractionalPage.truncatingRemainder(dividingBy: 1)

      color = fromColor.interpolate(to: colors[nextPage], percentage: transitionPercentage)
    } else {
      color = fromColor
    }
  }
}