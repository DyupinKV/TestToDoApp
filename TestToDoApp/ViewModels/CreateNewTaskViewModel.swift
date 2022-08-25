import Foundation
import RealmSwift

final class CreateNewTaskViewModel {
  private lazy var realmManager = RealmManager<Task>()
  
  func add(newTask: Task) {
    realmManager.add(obj: newTask)
  }
}
