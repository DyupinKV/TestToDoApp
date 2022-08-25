import Foundation
import UIKit

final class CategoriesCollectionView: UICollectionView {
  lazy var categories:[String] = [] {
    didSet {
      self.reloadData()
    }
  }
  var pickCategory: ((String) -> ())?
  lazy var pickedCategory = "" {
    didSet {
      self.reloadData()
    }
  }
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    showsHorizontalScrollIndicator = false
    register( CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    backgroundColor = UIColor.white
    
    dataSource = self
    delegate = self
    
    self.snp.makeConstraints { make in
      make.height.equalTo(76)
    }
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
    pickCategory?(categories[indexPath.row])
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
    let bgColor = (self.pickedCategory.isEmpty && category == "All categories") || self.pickedCategory == category ? .green : #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    
    cell.backgroundColor = bgColor
    cell.configure(with: category)
    return cell
  }
}
