import Foundation
import UIKit

final class TasksTableView: UITableView {
  lazy var tasks:[Task] = [] {
    didSet {
      self.reloadData()
    }
  }
  
  var taskComplete: ((Int) -> ())?
  var taskDelete: ((Int) -> ())?
  
  private let emptyTasksLabel: UILabel = {
    let emptyTasksLabel = UILabel()
    emptyTasksLabel.text = "You are lucky! You have no tasks"
    emptyTasksLabel.font = UIFont.systemFont(ofSize: 16)
    emptyTasksLabel.textColor = .darkGray
    
    return emptyTasksLabel
  }()
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    self.backgroundColor = .clear
    setTable()
    setupEmptyTasksLabel()
  }
  
  private func setTable() {
    register(TasksHeader.self, forHeaderFooterViewReuseIdentifier: TasksHeader.reuseIdentifier)
    register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    showsVerticalScrollIndicator = false
    
    dataSource = self
    delegate = self
    
  }
  
  private func setupEmptyTasksLabel() {
    addSubview(emptyTasksLabel)
    
    emptyTasksLabel.snp.makeConstraints { make in
      make.width.equalTo(self.snp.width)
      make.height.equalTo(90)
      make.top.equalTo(self.snp.top).offset(50)
      make.left.equalTo(self.snp.left).offset(16)
    }
  }
}

extension TasksTableView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = self.tasks[indexPath.row]
    
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: TaskCell.reuseIdentifier,
      for: indexPath
    ) as? TaskCell else {
      return UITableViewCell()
    }
    cell.configure(with: task)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let cellsCount = tasks.count
    if cellsCount == 0 {
      emptyTasksLabel.isHidden = false
    } else {
      emptyTasksLabel.isHidden = true
    }
    
    return cellsCount
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 86
  }
}

extension TasksTableView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    taskComplete?(indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TasksHeader.reuseIdentifier) as? TasksHeader else {
      return UIView()
    }
    view.title.text = "Tasks"
    
    return view
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    taskDelete?(indexPath.row)
  }
}
