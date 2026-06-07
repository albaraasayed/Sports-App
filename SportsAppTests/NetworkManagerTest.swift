//
//  NetworkManagerTest.swift
//  SportsAppTests
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import XCTest

@testable import SportsApp

final class NetworkManagerTests: XCTestCase {
    
    var realNetworkManager: NetworkManager!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        realNetworkManager = NetworkManager.shared
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDownWithError() throws {
        realNetworkManager = nil
        mockNetworkManager = nil
    }
    
    func testMockFetchLeaguesSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues): XCTAssertNotNil(leagues)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchLeaguesFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    
    func testMockFetchFixturesByLeagueSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchFixtures(sport: .football, leagueId: "1", fromDate: "2024-01-01", toDate: "2024-12-31") { result in
            switch result {
            case .success(let fixtures): XCTAssertNotNil(fixtures)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchFixturesByLeagueFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchFixtures(sport: .football, leagueId: "1", fromDate: "2024-01-01", toDate: "2024-12-31") { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    func testMockFetchTeamSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchTeam(sport: .football, teamId: "1") { result in
            switch result {
            case .success(let teams): XCTAssertNotNil(teams)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchTeamFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchTeam(sport: .football, teamId: "1") { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    func testMockFetchTeamsInLeagueSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "152") { result in
            switch result {
            case .success(let teams): XCTAssertNotNil(teams)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchTeamsInLeagueFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "152") { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    func testMockFetchTennisPlayerSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchTennisPlayer(playerId: "1") { result in
            switch result {
            case .success(let players): XCTAssertNotNil(players)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchTennisPlayerFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchTennisPlayer(playerId: "1") { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    
    func testMockFetchTennisPlayersInLeagueSuccess() {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.fetchTennisPlayersInLeague(leagueId: "1") { result in
            switch result {
            case .success(let players): XCTAssertNotNil(players)
            case .failure(_): XCTFail("Expected success")
            }
        }
    }
    
    func testMockFetchTennisPlayersInLeagueFailure() {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.fetchTennisPlayersInLeague(leagueId: "1") { result in
            switch result {
            case .success(_): XCTFail("Expected failure")
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
    }
    
    
    func testRealFetchLeaguesSuccess() {
        let expectation = expectation(description: "API - Leagues")
        realNetworkManager.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues): XCTAssertNotNil(leagues); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRealFetchFixturesByLeagueSuccess() {
        let expectation = expectation(description: "API - Fixtures By League")
        realNetworkManager.fetchFixtures(sport: .football, leagueId: "152", fromDate: "2024-01-01", toDate: "2024-12-31") { result in
            switch result {
            case .success(let fixtures): XCTAssertNotNil(fixtures); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRealFetchFixturesByLeagueFailure() {
        let expectation = expectation(description: "API - Fixtures By League Failure")
        realNetworkManager.fetchFixtures(sport: .football, leagueId: "INVALID_ID", fromDate: "2024-01-01", toDate: "2024-12-31") { result in
            switch result {
            case .success(let fixtures):
                XCTAssertNotNil(fixtures)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testRealFetchTeamSuccess() {
        let expectation = expectation(description: "API - Team")
        realNetworkManager.fetchTeam(sport: .football, teamId: "96") { result in
            switch result {
            case .success(let teams): XCTAssertNotNil(teams); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRealFetchTeamFailure() {
        let expectation = expectation(description: "API - Team Failure")
        realNetworkManager.fetchTeam(sport: .football, teamId: "INVALID_TEAM_ID") { result in
            switch result {
            case .success(let teams):
                XCTAssertTrue(teams.isEmpty, "Expected empty array for invalid ID")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    
    func testRealFetchTeamsInLeagueSuccess() {
        let expectation = expectation(description: "API - Teams In League")
        realNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "152") { result in
            switch result {
            case .success(let teams): XCTAssertNotNil(teams); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRealFetchTeamsInLeagueFailure() {
            let expectation = expectation(description: "API - Teams In League Failure")
            realNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "INVALID_LEAGUE") { result in
                switch result {
                case .success(let teams):
                    XCTAssertNotNil(teams)
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                expectation.fulfill()
            }
            waitForExpectations(timeout: 10)
        }
    

    func testRealFetchTennisPlayerSuccess() {
        let expectation = expectation(description: "API - Tennis Player")
        realNetworkManager.fetchTennisPlayer(playerId: "100") { result in
            switch result {
            case .success(let players): XCTAssertNotNil(players); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testRealFetchTennisPlayerFailure() {
        let expectation = expectation(description: "API - Tennis Player Failure")
        realNetworkManager.fetchTennisPlayer(playerId: "INVALID_PLAYER") { result in
            switch result {
            case .success(let players):
                XCTAssertTrue(players.isEmpty, "Expected empty array for invalid ID")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }
    

    func testRealFetchTennisPlayersInLeagueSuccess() {
        let expectation = expectation(description: "API - Tennis Players In League")
        realNetworkManager.fetchTennisPlayersInLeague(leagueId: "2000") { result in
            switch result {
            case .success(let players): XCTAssertNotNil(players); expectation.fulfill()
            case .failure(let error): XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5)
    }
    
}
