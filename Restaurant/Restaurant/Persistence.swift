import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (store,error) in
            if let error = error {
                print("Core Data failed: \(error.localizedDescription)")
            }
            else {
                print("Core Data loaded.")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    /*
    // XXX: this does not seem to work properly although it was given in the template:
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let result = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
        if result == nil {
            print("Clear did _not_ succeeed.")
        }
        else {
            print(result!)
         }
    }
     */

    // Delete all dishes one by one
    func clear_all() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
         fetchRequest.returnsObjectsAsFaults = false
         do {
             let results = try container.viewContext.fetch(fetchRequest)
             for object in results {
                 guard let objectData = object as? NSManagedObject else {continue}
                 container.viewContext.delete(objectData)
             }
         } catch let error {
             print("Delete all data error :", error)
         }
    }
    
    func save() {
        try? container.viewContext.save()
    }
}
