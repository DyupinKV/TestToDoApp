import UIKit

class ToDoCategoriesViewController: UIViewController {
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Categories"
    
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9982756558)
  }
}
