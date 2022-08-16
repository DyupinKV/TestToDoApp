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
    return #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
  case .Shopping:
    return #colorLiteral(red: 0.9998531938, green: 0, blue: 0.1240663752, alpha: 1)
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
    return #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
  case .Shopping:
    return #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)
  case .Sport:
    return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
  case .Event:
    return #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
  case .Work:
    return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
  }
}
