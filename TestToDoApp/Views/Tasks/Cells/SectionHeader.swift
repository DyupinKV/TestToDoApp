import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
  static let reuseId = "SectionHeader"
  let title = UILabel()
  
  override init(frame: CGRect) {
    super .init(frame: frame)
    
    customizeElements()
    setupConstrains()
  }
  
  private func customizeElements() {
    title.textColor = .black
    title.font = UIFont(name: "avenir", size: 20)
    
    title.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupConstrains() {
    addSubview(title)
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: topAnchor),
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      title.trailingAnchor.constraint(equalTo: trailingAnchor),
      title.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}
