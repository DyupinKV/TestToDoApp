import Foundation
import UIKit

class TaskCell: UITableViewCell {
  static var reuseIdentifier: String = "TaskCell"
  
  private lazy var gradientView = GradientView(from: .topTrailing, to: .bottomLeading, inColor: .purple, toColor: .blue)
  private lazy var taskTitle = UILabel()
  private lazy var categoryName = UILabel()
  private lazy var timeLabel = UILabel()
  private lazy var dateLabel = UILabel()
  private lazy var completeImgView: UIImageView = {
    let completeImgView:UIImageView = UIImageView()
    completeImgView.contentMode = UIView.ContentMode.scaleAspectFit
    
    return completeImgView
  }()
  
  private lazy var checked = UIImage(named: "Checkmark")
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor(white: 1, alpha: 1)
    selectionStyle = .none
    
    setupElements()
    
    self.layer.cornerRadius = 6
    self.clipsToBounds = true
  }
  
  private func setupElements() {
    setupGradienView()
    setupTimeLabel()
    setupDateLabel()

    setupTaskTitle()
    setupCategoryName()
    setupCompleteImgView()
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
    categoryName.textColor = endColor
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
  private func setupGradienView() {
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(gradientView)
    
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    gradientView.widthAnchor.constraint(equalToConstant: 8).isActive = true
    gradientView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
  }
  
  private func setupTaskTitle() {
    taskTitle.translatesAutoresizingMaskIntoConstraints = false
    addSubview(taskTitle)
    
    taskTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    taskTitle.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16).isActive = true
  }
  
  private func setupCategoryName() {
    categoryName.translatesAutoresizingMaskIntoConstraints = false
    addSubview(categoryName)
    
    categoryName.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 8).isActive = true
    categoryName.leadingAnchor.constraint(equalTo: taskTitle.leadingAnchor).isActive = true
  }
  
  private func setupTimeLabel() {
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(timeLabel)
    
    timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
  }
  
  private func setupDateLabel() {
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(dateLabel)
    
    dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
    dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
  }
  
  private func setupCompleteImgView() {
    completeImgView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(completeImgView)
    
    completeImgView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    completeImgView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    completeImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    completeImgView.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16).isActive = true
  }
}
