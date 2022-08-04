import Foundation
import RealmSwift

protocol ToDoViewModelDelegate: AnyObject {
  func updatedInfo()
  func updatedPickedCategory()
}

class ToDoViewModel {
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
    
    self.data = self.pickedCategory != "" ? tasks.filter({task in
      return task.category == pickedCategory}) : tasks
  }
  
  func tapCategory(category: String) -> Bool {
    if (pickedCategory == category) {
      showAllTasks()
      
      return true
    } else {
      let tasks = realmManager.findAll() ?? []
      
      pickedCategory = category
      self.data = tasks.filter({task in
        return task.category == category})
      
      return false
    }
  }
  
  //staraya realizacia
  //  func tapTaskForComplete(taskID: ObjectId, newCompletedStatus: Bool) {
  //    realmManager.updateTask(id: taskID, completed: newCompletedStatus)
  //    getData()
  //  }
  
  func tapTaskForComplete(taskIndex: Int, newCompletedStatus: Bool) {
    
    var task = data[taskIndex]
    
    task.completed = newCompletedStatus
    realmManager.update(obj: task, id: task.id)
    getData()
  }
  
  func showAllTasks() {
    pickedCategory = ""
    getData()
  }
}
