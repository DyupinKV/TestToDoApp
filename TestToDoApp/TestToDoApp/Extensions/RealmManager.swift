import Foundation
import RealmSwift

class RealmManager <T: RealmSwift.Object> {
  private(set) var localRealm: Realm?
  
  init() {
    openRealm()
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
  
  func add(obj: T) {
    if let localRealm = localRealm {
      do {
        try localRealm.write {
          localRealm.add(obj)
        }
      } catch {
        print("Error adding new obj to Realm \(error)")
      }
    }
  }
  
  func findAll() -> [T]? {
    let allTasks = localRealm?.objects(T.self)
    var tasks: [T] = []
    
    allTasks?.forEach { task in
      tasks.append(task)
    }
    return tasks
  }
  
  
  //budet ne nujno
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
  
  func update(obj: T, id: ObjectId) {
    if let localRealm = localRealm {
      do {
        let objToUpdate = localRealm.objects(T.self).filter(NSPredicate(format: "id == %@", id))
        guard !objToUpdate.isEmpty else { return }
        try localRealm.write {
          localRealm.add(obj, update: .modified)        }
      } catch {
        print("Error updating \(error)")
      }
    }
  }
}
