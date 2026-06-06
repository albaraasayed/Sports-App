//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol: AnyObject {
    func saveLeague(leagueId: String, name: String, logoUrl: String, logoData: Data?, country: String, sportType: String)
    func deleteLeague(leagueId: String)
    func fetchFavorites() -> [FavoriteEntity]
}

class CoreDataManager : CoreDataManagerProtocol {
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLeague(leagueId: String, name: String, logoUrl: String, logoData: Data?, country: String, sportType: String) {
        let league = FavoriteEntity(context: context)
        league.leagueId = leagueId
        league.name = name
        league.logo = logoUrl
        league.logoData = logoData
        league.country = country
        league.sportType = sportType
        
        try? context.save()
    }
    
    func deleteLeague(leagueId: String) {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %@", leagueId)
        
        if let result = try? context.fetch(fetchRequest), let league = result.first {
            context.delete(league)
            try? context.save()
        }
    }
    
    func fetchFavorites() -> [FavoriteEntity] {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    func isFavorite(leagueId: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueId == %@", leagueId)
        return (try? context.count(for: fetchRequest)) ?? 0 > 0
    }
}
