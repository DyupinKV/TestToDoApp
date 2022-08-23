import Foundation
import UIKit

final class CategoriesCollectionView: UICollectionView {
  private lazy var categories:[String] = []
  private lazy var vm = ToDoViewModel()
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    showsHorizontalScrollIndicator = false
    register( CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    backgroundColor = UIColor.white
    
    
    vm.categories.insert("All categories", at: 0)
    self.categories = vm.categories
    
    dataSource = self
    delegate = self
    
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 76).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  private func createCategoryLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 16
    layout.minimumInteritemSpacing = 16
    layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    layout.itemSize = CGSize(width: 130, height: 54)
    
    return layout
  }
}

extension CategoriesCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let category = categories[indexPath.row]
    vm.tapCategory(category: category)
    collectionView.reloadData()
  }
}

extension CategoriesCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let category = categories[indexPath.row]
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CategoryCell.reuseIdentifier,
      for: indexPath
    ) as? CategoryCell else {
      return UICollectionViewCell()
    }
    let pickedCategory = vm.pickedCategory
    let bgColor = (pickedCategory.isEmpty && category == "All categories") || pickedCategory == category ? .green : #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    
    cell.backgroundColor = bgColor
    cell.configure(with: category)
    return cell
  }
}
