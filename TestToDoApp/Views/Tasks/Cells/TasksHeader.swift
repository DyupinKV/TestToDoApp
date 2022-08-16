import Foundation
import UIKit

class TasksHeader: UITableViewHeaderFooterView {
  static let reuseIdentifier: String = "TaskHeader"
  let title = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    configureContents()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureContents() {
    title.textColor = .black
    title.font = UIFont.systemFont(ofSize: 20)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(title)
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: topAnchor),
      title.leadingAnchor.constraint(equalTo: leadingAnchor),
      title.trailingAnchor.constraint(equalTo: trailingAnchor),
      title.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
