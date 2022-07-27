import Foundation
import RealmSwift

protocol ToDoViewModelDelegate: AnyObject {
  func updatedInfo()
}

class ToDoViewModel {
  private var realmManager = RealmManager()
  private lazy var pickedCategory = ""
  lazy var categories = Categories.allCases.map { $0.rawValue }
  
  weak var delegate: ToDoViewModelDelegate?
  var data: [Task] = [] {
    didSet {
      delegate?.updatedInfo()
    }
  }
  
  func getData() {
    self.data = realmManager.tasks
  }
  
  func tapCategory(category: String) -> Bool {
    if (pickedCategory == category) {
      pickedCategory = ""
      getData()
      
      return true
    } else {
      pickedCategory = category
      self.data = realmManager.tasks .filter({task in
        return task.category == category})
      
      return false
    }
  }
  
  func tapTaskForComplete(taskID: ObjectId, newCompletedStatus: Bool) {
    realmManager.updateTask(id: taskID, completed: newCompletedStatus)
    getData()
  }
}

