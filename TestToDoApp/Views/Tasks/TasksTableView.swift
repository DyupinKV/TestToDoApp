import Foundation
import UIKit

final class TasksTableView: UITableView {
  private lazy var vm = ToDoViewModel()
  private lazy var tasks:[Task] = []
  
  private let emptyTasksLabel: UILabel = {
    let emptyTasksLabel = UILabel()
    emptyTasksLabel.text = "You are lucky! You have no tasks"
    emptyTasksLabel.font = UIFont.systemFont(ofSize: 16)
    emptyTasksLabel.textColor = .darkGray
    
    return emptyTasksLabel
  }()
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    vm.delegate = self
    vm.getData()
    
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setLayout() {
    self.backgroundColor = .clear
    setTable()
  }
  
  func setTable() {
    register(TasksHeader.self, forHeaderFooterViewReuseIdentifier: TasksHeader.reuseIdentifier)
    register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    showsVerticalScrollIndicator = false
    
    dataSource = self
    delegate = self
    
    addSubview(emptyTasksLabel)
  }
  
  
  private func setupEmptyTasksLabel() {
    emptyTasksLabel.translatesAutoresizingMaskIntoConstraints = false
    emptyTasksLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32).isActive = true
    emptyTasksLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
    emptyTasksLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
  }
  
  public func fire () {
    print("sadad FIRE FIRE FIRE")
  }
}

extension TasksTableView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = tasks[indexPath.row]
    
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
    let task = tasks[indexPath.row]
    vm.tapTaskForComplete(taskIndex: indexPath.row, newCompletedStatus: !task.completed )
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
    vm.delete(taskIndex: indexPath.row)
  }
}

extension TasksTableView: ToDoViewModelDelegate {
  func updatedInfo() {
    print("FASDSAIJGIFGIJOS")
    DispatchQueue.main.async { [self] in
      self.tasks = vm.data
      self.reloadData()
    }
  }
}
