import Foundation
import UIKit
import SnapKit

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
    
    contentView.addSubview(title)
    
    title.snp.makeConstraints { make in
      make.top.left.right.bottom.equalToSuperview()
    }
  }
}
