//
//  NetworkManager.swift
//  SportsApp
//
//  Created by albaraa alsayed on 18/12/1447 AH.
//

import Foundation
import Alamofire

extension SportType {
    var baseURL: String {
        switch self {
        case .football: return APIConfig.footballBaseURL
        case .basketball: return APIConfig.basketballBaseURL
        case .cricket: return APIConfig.cricketBaseURL
        case .tennis: return APIConfig.tennisBaseURL
        }
    }
}

protocol NetworkManagerProtocol {
    func fetchLeagues(sport: SportType, completion: @escaping (Result<[League], Error>) -> Void)
    
    func fetchFixtures(sport: SportType, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void)
    
    func fetchFixtures(sport: SportType, leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void)
    
    func fetchTeam(sport: SportType, teamId: String, completion: @escaping (Result<[Team], Error>) -> Void)
    
    func fetchTeamsInLeague(sport: SportType, leagueId: String, completion: @escaping (Result<[Team], Error>) -> Void)
    
    func fetchTennisPlayer(playerId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void)
    
    func fetchTennisPlayersInLeague(leagueId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void)
}


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func fetchRawData<T: Decodable>(url: String, parameters: [String: String], responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let decodedObject = try decoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchLeagues(sport: SportType, completion: @escaping (Result<[League], Error>) -> Void) {
        let parameters = ["met": "Leagues", "APIkey": APIConfig.apiKey]
        
        fetchRawData(url: sport.baseURL, parameters: parameters, responseType: LeagueResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchFixtures(sport: SportType, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void) {
        let parameters = ["met": "Fixtures", "from": fromDate, "to": toDate, "APIkey": APIConfig.apiKey]
        
        fetchRawData(url: sport.baseURL, parameters: parameters, responseType: FixtureResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTeam(sport: SportType, teamId: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        let parameters = ["met": "Teams", "teamId": teamId, "APIkey": APIConfig.apiKey]
        
        fetchRawData(url: sport.baseURL, parameters: parameters, responseType: TeamResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTennisPlayer(playerId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void) {
        let parameters = ["met": "Players", "playerId": playerId, "APIkey": APIConfig.apiKey]
        
        fetchRawData(url: SportType.tennis.baseURL, parameters: parameters, responseType: TennisPlayerResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTeamsInLeague(sport: SportType, leagueId: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        let parameters = ["met": "Teams", "leagueId": leagueId, "APIkey": APIConfig.apiKey]
        
        fetchRawData(url: sport.baseURL, parameters: parameters, responseType: TeamResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchFixtures(sport: SportType, leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<[Fixture], Error>) -> Void) {
        
        let parameters = [
            "met": "Fixtures",
            "leagueId": leagueId,
            "from": fromDate,
            "to": toDate,
            "APIkey": APIConfig.apiKey
        ]
        
        fetchRawData(url: sport.baseURL, parameters: parameters, responseType: FixtureResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTennisPlayersInLeague(leagueId: String, completion: @escaping (Result<[TennisPlayer], Error>) -> Void) {
        let parameters = [
            "met": "Players",
            "leagueId": leagueId,
            "APIkey": APIConfig.apiKey
        ]
        
        fetchRawData(url: SportType.tennis.baseURL, parameters: parameters, responseType: TennisPlayerResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
