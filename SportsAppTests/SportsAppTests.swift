//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
       
    }

}



final class LeagueDetailsPresenterTests: XCTestCase {
    
    var sut: LeagueDetailsPresenter!
    var mockView: MockLeagueDetailsVC!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockView = MockLeagueDetailsVC()
        mockNetworkManager = MockNetworkManager(shouldReturnError: false)
        
        sut = LeagueDetailsPresenter(
            view: mockView,
            sportType: .football,
            leagueId: "152",
            leagueName: "Premier League",
            networkManager: mockNetworkManager
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockView = nil
        mockNetworkManager = nil
    }
    
    func testPresenterInitializationIsNotNull() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.leagueId, "152")
        XCTAssertEqual(sut.sportType, .football)
    }
    
    func testViewDidLoadTriggersFetchAndReloadsDataSuccessfully() {

        mockNetworkManager.shouldReturnError = false
        
        let expectation = expectation(description: "Wait for DispatchGroup to finish and call reloadData")
        mockView.reloadDataExpectation = expectation
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockView.isShowLoadingCalled)
        
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertTrue(self.mockView.isHideLoadingCalled)
            XCTAssertNotNil(self.mockView.reloadedTeams)
            XCTAssertNotNil(self.mockView.reloadedUpcomingMatches)
            XCTAssertNotNil(self.mockView.reloadedPastMatches)
        }
    }
    
    func testFetchTennisPlayersWhenSportIsTennis() {
        
        sut.sportType = .tennis
        
        let expectation = expectation(description: "Wait for Tennis data to reload")
        mockView.reloadDataExpectation = expectation
        
        sut.viewDidLoad()
        
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertNotNil(self.mockView.reloadedTennisPlayers)
        }
    }
}
