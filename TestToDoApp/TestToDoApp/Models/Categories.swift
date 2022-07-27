import Foundation
import UIKit

enum Categories: String, CaseIterable {
  case Personal
  case Shopping
  case Sport
  case Event
  case Work
}

func pickCategoryStartColor(category: Categories)-> UIColor {
  switch category {
  case .Personal:
    return #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
  case .Shopping:
    return #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
  case .Sport:
    return #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
  case .Event:
    return #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
  case .Work:
    return #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
  }
}

func pickCategoryEndColor(category: Categories)-> UIColor {
  switch category {
  case .Personal:
    return #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
  case .Shopping:
    return #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
  case .Sport:
    return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
  case .Event:
    return #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
  case .Work:
    return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
  }
}
