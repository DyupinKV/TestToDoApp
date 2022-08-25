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
    addSubview(categoryTitle)
    
    categoryTitle.snp.makeConstraints { make in
      make.top.equalTo(16)
      make.leading.equalTo(self.snp.leading).offset(8)
    }
  }
  
  private func setupGradientView() {
    addSubview(gradientView)
    
    gradientView.snp.makeConstraints { make in
      make.trailing.equalTo(self.snp.trailing)
      make.bottom.equalTo(self.snp.bottom)
      make.width.equalTo(self.snp.width)
      make.height.equalTo(8)
    }
  }
}
