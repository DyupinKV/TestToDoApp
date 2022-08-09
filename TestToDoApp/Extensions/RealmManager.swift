import Foundation
import RealmSwift

final class RealmManager <T: RealmSwift.Object> {
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
  
  func update(_ object: T, with dictionary: [String: Any])  {
    if let localRealm = localRealm {
      do {
        try localRealm.write {
          for (key, value) in dictionary {
            object.setValue(value, forKey: key)
          }
        }
      } catch {
        print("Error updating obj \(error)")
      }
    }
  }
}
