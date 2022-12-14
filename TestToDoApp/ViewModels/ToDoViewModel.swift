import Foundation
import RealmSwift

protocol ToDoViewModelDelegate: AnyObject {
  func updatedInfo()
}

final class ToDoViewModel {
  private lazy var realmManager = RealmManager<Task>()
  
  lazy var pickedCategory = ""
  lazy var categories = Categories.allCases.map { $0.rawValue }
  
  weak var delegate: ToDoViewModelDelegate?
  var data: [Task] = [] {
    didSet {
      delegate?.updatedInfo()
    }
  }
  
  func getData() {
    let tasks = realmManager.findAll()?.sorted(by: { $0.date < $1.date }) ?? []
    
    self.data = self.pickedCategory.isEmpty ? tasks : tasks.filter({
      return $0.category == pickedCategory})
  }
  
  func tapCategory(category: String) {
    if (category == "All categories" || category == pickedCategory) {
      showAllTasks()
    } else {
      let tasks = realmManager.findAll() ?? []
      
      pickedCategory = category
      self.data = tasks.filter({$0.category == category})
    }
  }
  
  func tapTaskForComplete(taskIndex: Int) {
    let task = data[taskIndex]
    let dictionary = ["completed": !task.completed]
    realmManager.update(task, with: dictionary)
    getData()
  }
  
  func showAllTasks() {
    if (!pickedCategory.isEmpty) {
      pickedCategory = ""
      getData()
    }
  }
  
  func delete(taskIndex: Int) {
    let task = data[taskIndex]
    realmManager.delete(obj: task)
    getData()
  }
}
