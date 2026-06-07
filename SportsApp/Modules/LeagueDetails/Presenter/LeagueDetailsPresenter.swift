//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by albaraa alsayed on 16/12/1447 AH.
//
//

import Foundation

protocol LeagueDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func toggleFavorite()
    func didSelectTeam(teamId: Int)
}

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    weak var view: LeagueDetailsVCProtocol?
    
    var teams: [Team] = []
    var tennisPlayers: [TennisPlayer] = []
    var upcomingMatches: [Fixture] = []
    var pastMatches: [Fixture] = []
    
    var sportType: SportType?
    var leagueId: String?
    var leagueName: String?
    
    var isFavorite: Bool = false
    
    let networkManager: NetworkManagerProtocol
    
    init(view: LeagueDetailsVCProtocol, sportType: SportType, leagueId: String, leagueName: String, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.view = view
        self.sportType = sportType
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        
        if let id = leagueId {
            isFavorite = CoreDataManager.shared.isFavorite(leagueId: id)
            view?.updateFavoriteButtonState(isFavorite: isFavorite)
        }
        
        fetchData()
    }
    
    func toggleFavorite() {
            
            guard let id = leagueId, let sport = sportType, let name = leagueName else { return }
            
            let isCurrentlyFavorite = CoreDataManager.shared.isFavorite(leagueId: id)
            
            if isCurrentlyFavorite {
                CoreDataManager.shared.deleteLeague(leagueId: id)
                isFavorite = false
            } else {
                CoreDataManager.shared.saveLeague(
                    leagueId: id,
                    name: name,
                    logoUrl: "",
                    logoData: nil,
                    country: "Country name",
                    sportType: sport.rawValue
                )
                isFavorite = true
            }
            
            
            view?.updateFavoriteButtonState(isFavorite: isFavorite)
        }
    
    func didSelectTeam(teamId: Int) { }
    
    private func fetchData() {
        guard let sport = sportType, let id = leagueId else { return }
        view?.showLoading()
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        
        let nextYear = Calendar.current.date(byAdding: .day, value: 365, to: today)!
        let lastYear = Calendar.current.date(byAdding: .day, value: -365, to: today)!
        
        let todayString = formatter.string(from: today)
        let nextYearString = formatter.string(from: nextYear)
        let lastYearString = formatter.string(from: lastYear)
        
        let group = DispatchGroup()
        
        group.enter()
        if sport == .tennis {
            networkManager.fetchTennisPlayersInLeague(leagueId: id) { [weak self] result in
                if case .success(let players) = result {
                    self?.tennisPlayers = players
                }
                group.leave()
            }
        } else {
            networkManager.fetchTeamsInLeague(sport: sport, leagueId: id) { [weak self] result in
                if case .success(let fetchedTeams) = result {
                    self?.teams = fetchedTeams
                }
                group.leave()
            }
        }
        
        group.enter()
        networkManager.fetchFixtures(sport: sport, leagueId: id, fromDate: todayString, toDate: nextYearString) { [weak self] result in
            if case .success(let fixtures) = result {
                self?.upcomingMatches = fixtures.filter { match in
                    let status = match.eventStatus ?? ""
                    return status == "" || status == "Not Started"
                }
            }
            group.leave()
        }
        
        group.enter()
        networkManager.fetchFixtures(sport: sport, leagueId: id, fromDate: lastYearString, toDate: todayString) { [weak self] result in
            if case .success(let fixtures) = result {
                self?.pastMatches = fixtures.filter { match in
                    return match.eventStatus == "Finished"
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.hideLoading()
            self.view?.reloadData(teams: self.teams, tennisPlayers: self.tennisPlayers, upcoming: self.upcomingMatches, past: self.pastMatches)
        }
    }
}
