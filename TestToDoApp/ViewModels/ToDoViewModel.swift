import Foundation
import RealmSwift

protocol ToDoViewModelDelegate: AnyObject {
  func updatedInfo()
  func updatedPickedCategory()
}

final class ToDoViewModel {
  private lazy var realmManager = RealmManager<Task>()
  
  lazy var pickedCategory = "" {
    didSet {
      delegate?.updatedPickedCategory()
    }
  }
  lazy var categories = Categories.allCases.map { $0.rawValue }
  
  weak var delegate: ToDoViewModelDelegate?
  var data: [Task] = [] {
    didSet {
      delegate?.updatedInfo()
    }
  }
  
  func getData() {
    let tasks = realmManager.findAll() ?? []
    
    self.data = self.pickedCategory != "" ? tasks.filter({
      return $0.category == pickedCategory}) : tasks
  }
  
  func tapCategory(category: String) -> Bool {
    if (pickedCategory == category) {
      showAllTasks()
      
      return true
    } else {
      let tasks = realmManager.findAll() ?? []
      
      pickedCategory = category
      self.data = tasks.filter({$0.category == category})
      
      return false
    }
  }
  
  func tapTaskForComplete(taskIndex: Int, newCompletedStatus: Bool) {
    let task = data[taskIndex]
    let dictionary = ["completed": newCompletedStatus]
    realmManager.update(task, with: dictionary)
    getData()
  }
  
  func showAllTasks() {
    pickedCategory = ""
    getData()
  }
}
