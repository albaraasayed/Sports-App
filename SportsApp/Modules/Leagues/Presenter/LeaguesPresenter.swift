//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 16/12/1447 AH.
//

import Foundation
import SDWebImage 

protocol LeaguesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectLeague(at index: Int)
    func setSportType(sport: SportType)
    func searchLeagues(with query: String)
    
    func toggleFavorite(league: League, isNowFavorite: Bool)
    func isFavorite(leagueId: String) -> Bool
}

class LeaguesPresenter: LeaguesPresenterProtocol {
    
    weak var view: LeaguesViewProtocol?
    var sportType: SportType?
    
    var allLeagues: [League] = []
    var leagues: [League] = []
    
    let networkManager: NetworkManagerProtocol
    
    init(view: LeaguesViewProtocol, sportType: SportType, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.view = view
        self.sportType = sportType
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        guard let sportType = sportType else { return }
        view?.showLoading()
        
        networkManager.fetchLeagues(sport: sportType) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case .success(let fetchedLeagues):
                    self.allLeagues = fetchedLeagues
                    self.leagues = fetchedLeagues
                    self.view?.displayLeagues(leagues: self.leagues)
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func searchLeagues(with query: String) {
        if query.isEmpty {
            self.leagues = allLeagues
        } else {
            self.leagues = allLeagues.filter { league in
                guard let name = league.leagueName else { return false }
                return name.lowercased().contains(query.lowercased())
            }
        }
        view?.displayLeagues(leagues: self.leagues)
    }
    
    func didSelectLeague(at index: Int) { }
    
    func setSportType(sport: SportType) {
        self.sportType = sport
    }
    
    func isFavorite(leagueId: String) -> Bool {
        return CoreDataManager.shared.isFavorite(leagueId: leagueId)
    }
    
    func toggleFavorite(league: League, isNowFavorite: Bool) {
        guard let id = league.leagueKey else { return }
        let leagueId = "\(id)"
        
        if isNowFavorite {
            let logoUrl = league.leagueLogo ?? ""
            let name = league.leagueName ?? "League Name"
            let sportString = sportType?.rawValue ?? ""
            
            let countryOrYear: String
            if sportType == .cricket {
                countryOrYear = league.leagueYear ?? "Year"
            } else {
                countryOrYear = league.countryName ?? "Country"
            }
            
            if let url = URL(string: logoUrl) {
                SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil) { (image, data, error, cacheType, finished, imageURL) in
                    let imageDataToSave = data ?? image?.pngData()
                    CoreDataManager.shared.saveLeague(
                        leagueId: leagueId,
                        name: name,
                        logoUrl: logoUrl,
                        logoData: imageDataToSave,
                        country: countryOrYear,
                        sportType: sportString
                    )
                }
            } else {
                CoreDataManager.shared.saveLeague(
                    leagueId: leagueId,
                    name: name,
                    logoUrl: logoUrl,
                    logoData: nil,
                    country: countryOrYear,
                    sportType: sportString
                )
            }
            
        } else {
            CoreDataManager.shared.deleteLeague(leagueId: leagueId)
        }
    }
}
