import Foundation
import CoreData

class LocalDataSource {
    static let shared = LocalDataSource()
    private init() {}
    
    private let context = CoreDataStack.shared.context
    
    // MARK: - 💾 GENERIC CACHING (Existing)
    
    func cacheData<T: Codable>(_ data: T, forSport sport: String, endpoint: String) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CachedData")
            fetchRequest.predicate = NSPredicate(format: "sportType == %@ AND endpointType == %@", sport, endpoint)
            
            if let results = try? self.context.fetch(fetchRequest), let oldRecord = results.first {
                self.context.delete(oldRecord)
            }
            
            guard let encodedData = try? JSONEncoder().encode(data) else { return }
            
            let entity = NSEntityDescription.entity(forEntityName: "CachedData", in: self.context)!
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(sport, forKey: "sportType")
            managedObject.setValue(endpoint, forKey: "endpointType")
            managedObject.setValue(encodedData, forKey: "rawJSONData")
            
            CoreDataStack.shared.saveContext()
        }
    }
    
    func fetchCachedData<T: Codable>(forSport sport: String, endpoint: String, completion: @escaping (T?) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CachedData")
            fetchRequest.predicate = NSPredicate(format: "sportType == %@ AND endpointType == %@", sport, endpoint)
            
            guard let results = try? self.context.fetch(fetchRequest),
                  let record = results.first,
                  let rawData = record.value(forKey: "rawJSONData") as? Data else {
                completion(nil)
                return
            }
            let decoded = try? JSONDecoder().decode(T.self, from: rawData)
            completion(decoded)
        }
    }
    
    // Deletes offline data for a specific league to free up space
    func deleteCache(forSport sport: String, containingKey key: String) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CachedData")
            fetchRequest.predicate = NSPredicate(format: "sportType == %@ AND endpointType CONTAINS %@", sport, key)
            
            if let results = try? self.context.fetch(fetchRequest) {
                for object in results { self.context.delete(object) }
                CoreDataStack.shared.saveContext()
            }
        }
    }
    
    // MARK: - ⭐ FAVORITES MANAGEMENT (New)
    
    func saveFavoriteLeague(_ league: FavoriteLeague) {
        context.perform {
            // Prevent duplicates
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
            fetchRequest.predicate = NSPredicate(format: "leagueId == %@", league.leagueId)
            if let results = try? self.context.fetch(fetchRequest), !results.isEmpty { return }
            
            let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: self.context)!
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(league.leagueId, forKey: "leagueId")
            managedObject.setValue(league.name, forKey: "name")
            managedObject.setValue(league.logo, forKey: "logo")
            managedObject.setValue(league.sport, forKey: "sportType")
            
            CoreDataStack.shared.saveContext()
        }
    }
    
    func removeFavoriteLeague(leagueId: String) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
            fetchRequest.predicate = NSPredicate(format: "leagueId == %@", leagueId)
            
            if let results = try? self.context.fetch(fetchRequest) {
                for object in results { self.context.delete(object) }
                CoreDataStack.shared.saveContext()
            }
        }
    }
    
    func fetchAllFavorites(completion: @escaping ([FavoriteLeague]) -> Void) {
        context.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
            guard let results = try? self.context.fetch(fetchRequest) else {
                completion([])
                return
            }
            
            let favorites = results.compactMap { record -> FavoriteLeague? in
                guard let id = record.value(forKey: "leagueId") as? String,
                      let name = record.value(forKey: "name") as? String,
                      let logo = record.value(forKey: "logo") as? String,
                      let sport = record.value(forKey: "sportType") as? String else { return nil }
                return FavoriteLeague(leagueId: id, name: name, logo: logo, sport: sport)
            }
            completion(favorites)
        }
    }
}