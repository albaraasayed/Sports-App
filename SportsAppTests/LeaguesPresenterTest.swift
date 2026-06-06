//
//  LeaguesPresenterTest.swift
//  SportsAppTests
//
//  Created by albaraa alsayed on 20/12/1447 AH.
//

import XCTest
@testable import SportsApp

final class LeaguesPresenterTests: XCTestCase {
    
    var sut: LeaguesPresenter!
    var mockView: MockLeaguesView!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockView = MockLeaguesView()
        mockNetworkManager = MockNetworkManager(shouldReturnError: false)
        
        sut = LeaguesPresenter(
            view: mockView,
            sportType: .football,
            networkManager: mockNetworkManager
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockView = nil
        mockNetworkManager = nil
    }
    
    func testPresenterInitialization() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.sportType, .football)
    }
    
    func testSetSportTypeUpdatesProperty() {
        sut.setSportType(sport: .basketball)
        XCTAssertEqual(sut.sportType, .basketball)
    }
    
    func testViewDidLoadFetchesAndDisplaysLeaguesSuccess() {

        mockNetworkManager.shouldReturnError = false
        
        let dummyLeague1 = League(leagueKey: 1, leagueName: "Premier League", countryName: "England", leagueLogo: nil, leagueYear: nil)
        let dummyLeague2 = League(leagueKey: 2, leagueName: "La Liga", countryName: "Spain", leagueLogo: nil, leagueYear: nil)
        mockNetworkManager.mockLeagues = [dummyLeague1, dummyLeague2]
        
        let expectation = expectation(description: "Wait for displayLeagues to be called on main thread")
        mockView.displayLeaguesExpectation = expectation
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockView.isShowLoadingCalled)
        
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertTrue(self.mockView.isHideLoadingCalled)
            XCTAssertNotNil(self.mockView.displayedLeagues)
            XCTAssertEqual(self.mockView.displayedLeagues?.count, 2)
            XCTAssertEqual(self.sut.allLeagues.count, 2)
        }
    }
    
    func testViewDidLoadShowsErrorOnFailure() {
        mockNetworkManager.shouldReturnError = true
        
        let expectation = expectation(description: "Wait for showError to be called on main thread")
        mockView.showErrorExpectation = expectation
        
        sut.viewDidLoad()
        
        // Assert
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertTrue(self.mockView.isHideLoadingCalled)
            XCTAssertNotNil(self.mockView.errorMessage)
            XCTAssertNil(self.mockView.displayedLeagues)
        }
    }
    
    // MARK: - Search Logic Tests
    func testSearchLeaguesWithEmptyQueryReturnsAllLeagues() {
        
        let dummyLeague = League(leagueKey: 1, leagueName: "Premier League", countryName: "England", leagueLogo: nil, leagueYear: nil)
        sut.allLeagues = [dummyLeague]
        
        
        sut.searchLeagues(with: "")
        
        // Assert
        XCTAssertEqual(sut.leagues.count, 1)
        XCTAssertEqual(mockView.displayedLeagues?.count, 1)
    }
    
    func testSearchLeaguesWithValidQueryFiltersCorrectly() {
        // Arrange
        let league1 = League(leagueKey: 1, leagueName: "Premier League", countryName: "England", leagueLogo: nil, leagueYear: nil)
        let league2 = League(leagueKey: 2, leagueName: "La Liga", countryName: "Spain", leagueLogo: nil, leagueYear: nil)
        sut.allLeagues = [league1, league2]
        
        // Act
        sut.searchLeagues(with: "Premier")
        
        // Assert
        XCTAssertEqual(sut.leagues.count, 1)
        XCTAssertEqual(sut.leagues.first?.leagueName, "Premier League")
        XCTAssertEqual(mockView.displayedLeagues?.first?.leagueName, "Premier League")
    }
    
    func testSearchLeaguesIsCaseInsensitive() {
        // Arrange
        let league = League(leagueKey: 1, leagueName: "Serie A", countryName: "Italy", leagueLogo: nil, leagueYear: nil)
        sut.allLeagues = [league]
        
        // Act
        sut.searchLeagues(with: "serie a")
        
        // Assert
        XCTAssertEqual(sut.leagues.count, 1)
    }
    
    func testSearchLeaguesWithNoMatchReturnsEmpty() {
        // Arrange
        let league = League(leagueKey: 1, leagueName: "Bundesliga", countryName: "Germany", leagueLogo: nil, leagueYear: nil)
        sut.allLeagues = [league]
        
        // Act
        sut.searchLeagues(with: "NBA")
        
        // Assert
        XCTAssertTrue(sut.leagues.isEmpty)
        XCTAssertTrue(mockView.displayedLeagues?.isEmpty == true)
    }
}
