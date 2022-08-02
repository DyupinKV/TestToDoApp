import Foundation
import RealmSwift

final class Task: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var title = ""
  @Persisted var time = ""
  @Persisted var date = ""
  @Persisted var category = ""
  @Persisted var completed = false
}
