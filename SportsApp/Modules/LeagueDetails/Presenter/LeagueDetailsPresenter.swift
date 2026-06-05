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
    
    var isFavorite: Bool = false
    
    init(view: LeagueDetailsVCProtocol, sportType: SportType, leagueId: String) {
        self.view = view
        self.sportType = sportType
        self.leagueId = leagueId
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        
        view?.updateFavoriteButtonState(isFavorite: isFavorite)
    }
    
    func didSelectTeam(teamId: Int) { }
    
    private func fetchData() {
        guard let sport = sportType, let id = leagueId else { return }
        view?.showLoading()
        
        let formatter = DateFormatter()
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
            NetworkManager.shared.fetchTennisPlayersInLeague(leagueId: id) { [weak self] result in
                if case .success(let players) = result {
                    self?.tennisPlayers = players
                }
                group.leave()
            }
        } else {
            NetworkManager.shared.fetchTeamsInLeague(sport: sport, leagueId: id) { [weak self] result in
                if case .success(let fetchedTeams) = result {
                    self?.teams = fetchedTeams
                }
                group.leave()
            }
        }
        
        group.enter()
        NetworkManager.shared.fetchFixtures(sport: sport, leagueId: id, fromDate: todayString, toDate: nextYearString) { [weak self] result in
            if case .success(let fixtures) = result {
                self?.upcomingMatches = fixtures
            }
            group.leave()
        }
        
        group.enter()
        NetworkManager.shared.fetchFixtures(sport: sport, leagueId: id, fromDate: lastYearString, toDate: todayString) { [weak self] result in
            if case .success(let fixtures) = result {
                self?.pastMatches = fixtures
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
