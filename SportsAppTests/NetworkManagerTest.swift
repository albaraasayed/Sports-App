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
    
    func testMockFetchTeamsSuccess() {
        mockNetworkManager.shouldReturnError = false
        
        mockNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "152") { result in
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
            case .failure(_):
                XCTFail("Expected success but got error")
            }
        }
    }
    
    func testMockFetchTeamsFailure() {
        mockNetworkManager.shouldReturnError = true
        
        mockNetworkManager.fetchTeamsInLeague(sport: .football, leagueId: "152") { result in
            switch result {
            case .success(_):
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testRealFetchLeagues() {
        let expectation = expectation(description: "Waiting for Alamofire API to fetch leagues")
        
        realNetworkManager.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues):
                XCTAssertNotNil(leagues)
                XCTAssertGreaterThan(leagues.count, 0, "Leagues array should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Network request failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 5)
    }
}
