import Foundation
import UIKit

class TaskCell:UICollectionViewCell {
  static var reuseIdentifier: String = "TaskCell"
  
  let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .purple, toColor: .blue)
  let taskTitle = UILabel()
  let categoryName = UILabel()
  let timeLabel = UILabel()
  let dateLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(white: 1, alpha: 1)
    
    setupElements()
    setupConstrains()
    
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
  }
  
  func setupElements() {
    taskTitle.translatesAutoresizingMaskIntoConstraints = false
    categoryName.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    
    categoryName.textColor = #colorLiteral(red: 0.4965081215, green: 0.5498962402, blue: 0.596957624, alpha: 1)
  }
  
  func configure(with task:Task) {
    guard let category = Categories(rawValue: task.category)  else {return}
    let startColor = pickCategoryStartColor(category: category)
    let endColor = pickCategoryEndColor(category: category)
    
    gradientView.setupGradientColors(startColor: startColor, endColor: endColor)
    taskTitle.text = task.title
    categoryName.text = task.category
    timeLabel.text = task.time
    dateLabel.text = task.date
    
    let backgroundColor = task.completed ? #colorLiteral(red: 0.4722054005, green: 0.7610591054, blue: 0.7004293799, alpha: 1) : #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    self.backgroundColor = backgroundColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TaskCell {
  func setupConstrains() {
    addSubview(gradientView)
    addSubview(taskTitle)
    addSubview(categoryName)
    addSubview(dateLabel)
    addSubview(timeLabel)
    
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    gradientView.widthAnchor.constraint(equalToConstant: 8).isActive = true
    gradientView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
    taskTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    taskTitle.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16).isActive = true
    
    categoryName.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 8).isActive = true
    categoryName.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor).isActive = true
    
    timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    
    dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
  }
}
