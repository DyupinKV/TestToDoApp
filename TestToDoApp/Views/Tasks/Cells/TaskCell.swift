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
    addSubview(gradientView)
    
    gradientView.snp.makeConstraints { make in
      make.trailing.equalTo(self.snp.trailing)
      make.height.equalTo(self.snp.width)
      make.width.equalTo(8)
    }
  }
  
  private func setupTimeLabel() {
    addSubview(timeLabel)
    
    timeLabel.snp.makeConstraints { make in
      make.top.equalTo(self.snp.top).offset(16)
      make.leading.equalTo(self.snp.leading).offset(16)
    }
  }
  
  private func setupDateLabel() {
    addSubview(dateLabel)
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(timeLabel.snp.bottom).offset(8)
      make.leading.equalTo(self.snp.leading).offset(16)
    }
  }
  
  private func setupTaskTitle() {
    addSubview(taskTitle)
    
    taskTitle.snp.makeConstraints { make in
      make.top.equalTo(self.snp.top).offset(16)
      make.leading.equalTo(dateLabel.snp.trailing).offset(16)
    }
  }
  
  private func setupCategoryName() {
    addSubview(categoryName)
    
    categoryName.snp.makeConstraints { make in
      make.top.equalTo(taskTitle.snp.bottom).offset(8)
      make.leading.equalTo(taskTitle.snp.leading)
    }
  }
  
  private func setupCompleteImgView() {
    addSubview(completeImgView)
    
    completeImgView.snp.makeConstraints { make in
      make.width.height.equalTo(30)
      make.centerY.equalTo(self.snp.centerY)
      make.trailing.equalTo(gradientView.snp.leading).offset(-16)
    }
  }
}
