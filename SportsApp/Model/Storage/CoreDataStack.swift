import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        // Note: Your friend must create a Core Data model file named 'SportsModel' in Xcode
        let container = NSPersistentContainer(name: "SportsModel")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Core Data Save Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}