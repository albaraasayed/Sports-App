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
    
    
    private func createDummyLeague(id: Int, name: String, country: String) -> League {
        let jsonString = """
        {
            "league_key": \(id),
            "league_name": "\(name)",
            "country_name": "\(country)",
            "league_logo": null,
            "league_year": null
        }
        """
        let data = Data(jsonString.utf8)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(League.self, from: data)
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
        
        let dummyLeague1 = createDummyLeague(id: 1, name: "Premier League", country: "England")
        let dummyLeague2 = createDummyLeague(id: 2, name: "La Liga", country: "Spain")
        
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
        
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertTrue(self.mockView.isHideLoadingCalled)
            XCTAssertNotNil(self.mockView.errorMessage)
            XCTAssertNil(self.mockView.displayedLeagues)
        }
    }
    

    func testSearchLeaguesWithEmptyQueryReturnsAllLeagues() {
        let dummyLeague = createDummyLeague(id: 1, name: "Premier League", country: "England")
        sut.allLeagues = [dummyLeague]
        
        sut.searchLeagues(with: "")
        
        XCTAssertEqual(sut.leagues.count, 1)
        XCTAssertEqual(mockView.displayedLeagues?.count, 1)
    }
    
    func testSearchLeaguesWithValidQueryFiltersCorrectly() {
        let league1 = createDummyLeague(id: 1, name: "Premier League", country: "England")
        let league2 = createDummyLeague(id: 2, name: "La Liga", country: "Spain")
        sut.allLeagues = [league1, league2]
        
        sut.searchLeagues(with: "Premier")
        
        XCTAssertEqual(sut.leagues.count, 1)
        XCTAssertEqual(sut.leagues.first?.leagueName, "Premier League")
        XCTAssertEqual(mockView.displayedLeagues?.first?.leagueName, "Premier League")
    }
    
    func testSearchLeaguesIsCaseInsensitive() {
        let league = createDummyLeague(id: 1, name: "Serie A", country: "Italy")
        sut.allLeagues = [league]
        
        sut.searchLeagues(with: "serie a")
        
        XCTAssertEqual(sut.leagues.count, 1)
    }
    
    func testSearchLeaguesWithNoMatchReturnsEmpty() {
        let league = createDummyLeague(id: 1, name: "Bundesliga", country: "Germany")
        sut.allLeagues = [league]
        
        sut.searchLeagues(with: "NBA")
        
        XCTAssertTrue(sut.leagues.isEmpty)
        XCTAssertTrue(mockView.displayedLeagues?.isEmpty == true)
    }
}
