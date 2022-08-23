import Foundation
import UIKit

class CategoryCell:UICollectionViewCell {
  static var reuseIdentifier: String = "CategoryCell"
  
  private lazy var gradientView = GradientView(from: .topLeading, to: .bottomTrailing, inColor: .clear, toColor: .clear)
  private lazy var categoryTitle = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(white: 1, alpha: 1)
    
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    
    setupElements()
  }
  
  private func setupElements() {
    setupCategoryTitle()
    setupGradientView()
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
  private func setupCategoryTitle() {
    categoryTitle.translatesAutoresizingMaskIntoConstraints = false
    addSubview(categoryTitle)
    
    categoryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    categoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    categoryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
  }
  
  private func setupGradientView() {
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(gradientView)
    
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    gradientView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    gradientView.heightAnchor.constraint(equalToConstant: 8).isActive = true
  }
}
