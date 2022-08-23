import Foundation
import UIKit

class CategoriesCollectionViewLayout: UICollectionViewFlowLayout {
  override init() {
    super.init()
    scrollDirection = .horizontal
    minimumLineSpacing = 16
    minimumInteritemSpacing = 16
    sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    itemSize = CGSize(width: 130, height: 54)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
