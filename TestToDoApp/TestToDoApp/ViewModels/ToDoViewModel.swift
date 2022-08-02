import Foundation
import RealmSwift

protocol ToDoViewModelDelegate: AnyObject {
  func updatedInfo()
  func updatedPickedCategory()
}

class ToDoViewModel {
  private lazy var realmManager = RealmManager()
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
    self.data = self.pickedCategory != "" ? realmManager.tasks.filter({task in
      return task.category == pickedCategory}) : realmManager.tasks
  }
  
  func tapCategory(category: String) -> Bool {
    if (pickedCategory == category) {
      showAllTasks()
      
      return true
    } else {
      pickedCategory = category
      self.data = realmManager.tasks.filter({task in
        return task.category == category})
      
      return false
    }
  }
  
  func tapTaskForComplete(taskID: ObjectId, newCompletedStatus: Bool) {
    realmManager.updateTask(id: taskID, completed: newCompletedStatus)
    getData()
  }
  
  func showAllTasks() {
    pickedCategory = ""
    getData()
  }
}

