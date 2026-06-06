//
//  MockNetwork.swift
//  SportsAppTests
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import XCTest
@testable import SportsApp

class MockLeagueDetailsVC: LeagueDetailsVCProtocol {
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var updatedFavoriteState: Bool?
    
    var reloadedTeams: [Team]?
    var reloadedTennisPlayers: [TennisPlayer]?
    var reloadedUpcomingMatches: [Fixture]?
    var reloadedPastMatches: [Fixture]?
    
    var reloadDataExpectation: XCTestExpectation?
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func hideLoading() {
        isHideLoadingCalled = true
    }
    
    func updateFavoriteButtonState(isFavorite: Bool) {
        updatedFavoriteState = isFavorite
    }
    
    func reloadData(teams: [Team], tennisPlayers: [TennisPlayer], upcoming: [Fixture], past: [Fixture]) {
        self.reloadedTeams = teams
        self.reloadedTennisPlayers = tennisPlayers
        self.reloadedUpcomingMatches = upcoming
        self.reloadedPastMatches = past
        
        reloadDataExpectation?.fulfill()
    }
}


class MockNetworkManager: NetworkManagerProtocol {
    
    var shouldReturnError: Bool
    
    var mockTeams: [Team] = []
    var mockTennisPlayers: [TennisPlayer] = []
    var mockUpcomingFixtures: [Fixture] = []
    
    enum ResponseError: Error {
        case fetchError
    }
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchLeagues(sport: SportType, completion: @escaping (Result<[League], Error>) -> Void) { }
    
    func fetchFixtures(sport: SportType, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(ResponseError.fetchError))
        } else {
            completion(.success(mockUpcomingFixtures))
        }
    }
    
    func fetchFixtures(sport: SportType, leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(ResponseError.fetchError))
        } else {
            completion(.success(mockUpcomingFixtures))
        }
    }
    
    func fetchTeam(sport: SportType, teamId: String, completion: @escaping (Result<[Team], Error>) -> Void) { }
    
    func fetchTeamsInLeague(sport: SportType, leagueId: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(ResponseError.fetchError))
        } else {
            completion(.success(mockTeams))
        }
    }
    
    func fetchTennisPlayer(playerId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void) { }
    
    func fetchTennisPlayersInLeague(leagueId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(ResponseError.fetchError))
        } else {
            completion(.success(mockTennisPlayers))
        }
    }
}


class MockLeaguesView: LeaguesViewProtocol {
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var displayedLeagues: [League]?
    var errorMessage: String?

    var displayLeaguesExpectation: XCTestExpectation?
    var showErrorExpectation: XCTestExpectation?
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func hideLoading() {
        isHideLoadingCalled = true
    }
    
    func displayLeagues(leagues: [League]) {
        self.displayedLeagues = leagues
        displayLeaguesExpectation?.fulfill()
    }
    
    func showError(message: String) {
        self.errorMessage = message
        showErrorExpectation?.fulfill()
    }
}
