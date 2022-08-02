import Foundation
import RealmSwift

class RealmManager: ObservableObject {
  private(set) var localRealm: Realm?
  @Published private(set) var tasks: [Task] = []
  
  init() {
    openRealm()
    getTasks()
  }
  
  func openRealm () {
    do {
      let config = Realm.Configuration(schemaVersion: 6)
      
      Realm.Configuration.defaultConfiguration = config
      localRealm = try Realm()
    } catch {
      print("Realm error: \(error)")
    }
  }
  
  func addTask(taskTitle: String, category: String, date: Date) {
    if let localRealm = localRealm {
      do {
        try localRealm.write {
          let newTask = Task(value: ["title": taskTitle, "category": category, "date": date, "completed": false])
          localRealm.add(newTask)
          getTasks()
          print("Adding new task: \(newTask)")
        }
      } catch {
        print("Error adding new task to Realm \(error)")
      }
    }
  }
  
  func getTasks() {
    if let localRealm = localRealm {
      let sortProperties = [SortDescriptor(keyPath: "date", ascending: true)]
      let allTasks = localRealm.objects(Task.self).sorted(by: sortProperties)
      tasks = []
      allTasks.forEach { task in
        tasks.append(task)
      }
    }
  }
  
  func updateTask(id: ObjectId, completed: Bool) {
    if let localRealm = localRealm {
      do {
        let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
        guard !taskToUpdate.isEmpty else { return }
        
        try localRealm.write {
          taskToUpdate[0].completed = completed
          print("Updating task with id \(id), complete status \(completed)")
        }
      } catch {
        print("Error updating task \(error)")
      }
    }
  }
  
  func deleteTask(id: ObjectId) {
    if let localRealm = localRealm {
      do {
        let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
        guard !taskToDelete.isEmpty else { return }
        
        try localRealm.write {
          localRealm.delete(taskToDelete)
          getTasks()
          print("Deleted task with id: \(id)")
        }
      } catch {
        print("Error deleting task: \(error)")
      }
    }
  }
}
