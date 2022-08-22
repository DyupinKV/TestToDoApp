import Foundation
import UIKit

class CategoryCell:UICollectionViewCell {
  static var reuseIdentifier: String = "CategoryCell"
  
  let gradientView = GradientView(from: .topLeading, to: .bottomTrailing, inColor: .clear, toColor: .clear)
  let categoryTitle = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(white: 1, alpha: 1)
    
    setupElements()
    setupConstrains()
    
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    
    addSubview(categoryTitle)
  }
  
  func setupElements() {
    categoryTitle.translatesAutoresizingMaskIntoConstraints = false
    gradientView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func configure(with category:String) {
    guard let category = Categories(rawValue: category) else {
      categoryTitle.text = "All categories"
      gradientView.setupGradientColors(startColor: .clear, endColor: .clear)
      return
    }
    
    let startColor = pickCategoryStartColor(category: category)
    let endColor = pickCategoryEndColor(category: category)
    
    categoryTitle.text = category.rawValue
    gradientView.setupGradientColors(startColor: startColor, endColor: endColor)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CategoryCell {
  func setupConstrains() {
    addSubview(gradientView)
    addSubview(categoryTitle)
    
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    gradientView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    gradientView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    
    categoryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    categoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    categoryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
  }
}
