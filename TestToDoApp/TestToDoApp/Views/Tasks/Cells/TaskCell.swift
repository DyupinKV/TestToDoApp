import Foundation
import UIKit

class TaskCell:UICollectionViewCell {
  static var reuseIdentifier: String = "TaskCell"
  
  let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .purple, toColor: .blue)
  let taskTitle = UILabel()
  let categoryName = UILabel()
  let timeLabel = UILabel()
  let dateLabel = UILabel()
  let completeImgView: UIImageView = {
    let completeImgView:UIImageView = UIImageView()
    completeImgView.contentMode = UIView.ContentMode.scaleAspectFit
    completeImgView.frame.size.width = 30
    completeImgView.frame.size.height = 30
    
    return completeImgView
  }()
  
  private lazy var checked = UIImage(named: "Checkmark")
  
  
  
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
    completeImgView.translatesAutoresizingMaskIntoConstraints = false
    
    categoryName.textColor = #colorLiteral(red: 0.4965081215, green: 0.5498962402, blue: 0.596957624, alpha: 1)
  }
  
  func configure(with task:Task) {
    guard let category = Categories(rawValue: task.category)  else {return}
    let startColor = pickCategoryStartColor(category: category)
    let endColor = pickCategoryEndColor(category: category)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let date = dateFormatter.string(from: task.date)
    dateFormatter.dateFormat = "HH:MM"
    let time = dateFormatter.string(from: task.date)
    
    
    gradientView.setupGradientColors(startColor: startColor, endColor: endColor)
    taskTitle.text = task.title
    categoryName.text = task.category
    timeLabel.text = time
    dateLabel.text = date
    
    let completedImg = task.completed ? checked : .none
    completeImgView.image = completedImg
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
    addSubview(completeImgView)
    
    let smallOffset = CGFloat(8)
    let largeOffset = CGFloat(16)
    
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    gradientView.widthAnchor.constraint(equalToConstant: smallOffset).isActive = true
    gradientView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    
    taskTitle.topAnchor.constraint(equalTo: topAnchor, constant: largeOffset).isActive = true
    taskTitle.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: largeOffset).isActive = true
    
    categoryName.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: smallOffset).isActive = true
    categoryName.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor).isActive = true
    
    timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: largeOffset).isActive = true
    timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: largeOffset).isActive = true
    
    dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: smallOffset).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: largeOffset).isActive = true
    
    completeImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    completeImgView.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -largeOffset).isActive = true
  }
}
