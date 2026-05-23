import Foundation

class SportsRepository {
    // Shared singleton instance accessed by all presenters
    static let shared = SportsRepository()
    private init() {}
    
    private let remote = NetworkManager.shared
    private let local = LocalDataSource.shared
    
    // MARK: - ⚽ FOOTBALL METHODS
    
    func getFootballLeagues(completion: @escaping (Result<FootballLeaguesResponse, Error>) -> Void) {
        let cacheKey = "Leagues"
        local.fetchCachedData(forSport: "Football", endpoint: cacheKey) { (cached: FootballLeaguesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.footballBaseURL, methodName: "Leagues") { (networkResult: Result<FootballLeaguesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Football", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getFootballFixtures(leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<FootballFixturesResponse, Error>) -> Void) {
        let cacheKey = "Fixtures_League_\(leagueId)_\(fromDate)_\(toDate)"
        let params: [String: Any] = ["leagueId": leagueId, "from": fromDate, "to": toDate]
        
        local.fetchCachedData(forSport: "Football", endpoint: cacheKey) { (cached: FootballFixturesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.footballBaseURL, methodName: "Fixtures", additionalParams: params) { (networkResult: Result<FootballFixturesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Football", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getFootballTeams(leagueId: String, completion: @escaping (Result<FootballTeamsResponse, Error>) -> Void) {
        let cacheKey = "Teams_League_\(leagueId)"
        let params: [String: Any] = ["leagueId": leagueId]
        
        local.fetchCachedData(forSport: "Football", endpoint: cacheKey) { (cached: FootballTeamsResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.footballBaseURL, methodName: "Teams", additionalParams: params) { (networkResult: Result<FootballTeamsResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Football", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getFootballPlayers(teamId: String, completion: @escaping (Result<FootballPlayersResponse, Error>) -> Void) {
        let cacheKey = "Players_Team_\(teamId)"
        let params: [String: Any] = ["teamId": teamId]
        
        local.fetchCachedData(forSport: "Football", endpoint: cacheKey) { (cached: FootballPlayersResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.footballBaseURL, methodName: "Teams", additionalParams: params) { (networkResult: Result<FootballPlayersResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Football", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    // MARK: - 🏀 BASKETBALL METHODS
    
    func getBasketballLeagues(completion: @escaping (Result<BasketballLeaguesResponse, Error>) -> Void) {
        let cacheKey = "Leagues"
        local.fetchCachedData(forSport: "Basketball", endpoint: cacheKey) { (cached: BasketballLeaguesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.basketballBaseURL, methodName: "Leagues") { (networkResult: Result<BasketballLeaguesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Basketball", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getBasketballFixtures(leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<BasketballFixturesResponse, Error>) -> Void) {
        let cacheKey = "Fixtures_League_\(leagueId)_\(fromDate)_\(toDate)"
        let params: [String: Any] = ["leagueId": leagueId, "from": fromDate, "to": toDate]
        
        local.fetchCachedData(forSport: "Basketball", endpoint: cacheKey) { (cached: BasketballFixturesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.basketballBaseURL, methodName: "Fixtures", additionalParams: params) { (networkResult: Result<BasketballFixturesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Basketball", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getBasketballTeams(leagueId: String, completion: @escaping (Result<BasketballTeamsResponse, Error>) -> Void) {
        let cacheKey = "Teams_League_\(leagueId)"
        let params: [String: Any] = ["leagueId": leagueId]
        
        local.fetchCachedData(forSport: "Basketball", endpoint: cacheKey) { (cached: BasketballTeamsResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.basketballBaseURL, methodName: "Teams", additionalParams: params) { (networkResult: Result<BasketballTeamsResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Basketball", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    // MARK: - 🏏 CRICKET METHODS
    
    func getCricketLeagues(completion: @escaping (Result<CricketLeaguesResponse, Error>) -> Void) {
        let cacheKey = "Leagues"
        local.fetchCachedData(forSport: "Cricket", endpoint: cacheKey) { (cached: CricketLeaguesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.cricketBaseURL, methodName: "Leagues") { (networkResult: Result<CricketLeaguesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Cricket", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getCricketFixtures(leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<CricketFixturesResponse, Error>) -> Void) {
        let cacheKey = "Fixtures_League_\(leagueId)_\(fromDate)_\(toDate)"
        let params: [String: Any] = ["leagueId": leagueId, "from": fromDate, "to": toDate]
        
        local.fetchCachedData(forSport: "Cricket", endpoint: cacheKey) { (cached: CricketFixturesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.cricketBaseURL, methodName: "Fixtures", additionalParams: params) { (networkResult: Result<CricketFixturesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Cricket", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getCricketTeams(leagueId: String, completion: @escaping (Result<CricketTeamsResponse, Error>) -> Void) {
        let cacheKey = "Teams_League_\(leagueId)"
        let params: [String: Any] = ["leagueId": leagueId]
        
        local.fetchCachedData(forSport: "Cricket", endpoint: cacheKey) { (cached: CricketTeamsResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.cricketBaseURL, methodName: "Teams", additionalParams: params) { (networkResult: Result<CricketTeamsResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Cricket", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    // MARK: - 🎾 TENNIS METHODS
    
    func getTennisTournaments(completion: @escaping (Result<TennisLeaguesResponse, Error>) -> Void) {
        let cacheKey = "Leagues"
        local.fetchCachedData(forSport: "Tennis", endpoint: cacheKey) { (cached: TennisLeaguesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.tennisBaseURL, methodName: "Leagues") { (networkResult: Result<TennisLeaguesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Tennis", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getTennisFixtures(leagueId: String, fromDate: String, toDate: String, completion: @escaping (Result<TennisFixturesResponse, Error>) -> Void) {
        let cacheKey = "Fixtures_League_\(leagueId)_\(fromDate)_\(toDate)"
        let params: [String: Any] = ["leagueId": leagueId, "from": fromDate, "to": toDate]
        
        local.fetchCachedData(forSport: "Tennis", endpoint: cacheKey) { (cached: TennisFixturesResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.tennisBaseURL, methodName: "Fixtures", additionalParams: params) { (networkResult: Result<TennisFixturesResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Tennis", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
    
    func getTennisPlayerDetails(playerId: String, completion: @escaping (Result<TennisPlayersResponse, Error>) -> Void) {
        let cacheKey = "Player_\(playerId)"
        let params: [String: Any] = ["playerId": playerId]
        
        local.fetchCachedData(forSport: "Tennis", endpoint: cacheKey) { (cached: TennisPlayersResponse?) in
            if let cachedData = cached { completion(.success(cachedData)) }
            
            self.remote.fetchData(from: APIConfig.tennisBaseURL, methodName: "Players", additionalParams: params) { (networkResult: Result<TennisPlayersResponse, Error>) in
                switch networkResult {
                case .success(let freshData):
                    self.local.cacheData(freshData, forSport: "Tennis", endpoint: cacheKey)
                    completion(.success(freshData))
                case .failure(let error):
                    if cached == nil { completion(.failure(error)) }
                }
            }
        }
    }
// MARK: - ⭐ FAVORITES & OFFLINE SYNC
    
    /// 1. Retrieve all saved Favorite Leagues
    func getFavoriteLeagues(completion: @escaping ([FavoriteLeague]) -> Void) {
        local.fetchAllFavorites(completion: completion)
    }
    
    /// 2. Add League to Favorites
    func addLeagueToFavorites(league: FavoriteLeague) {
        local.saveFavoriteLeague(league)
    }
    
    /// 3. Remove League from Favorites and clear its downloaded cache
    func removeLeagueFromFavorites(leagueId: String, sport: String) {
        local.removeFavoriteLeague(leagueId: leagueId)
        // Free up device storage by deleting the cached Teams & Fixtures for this league
        local.deleteCache(forSport: sport, containingKey: "League_\(leagueId)")
    }
    
    /// 4. Update League from the Internet (Forces a background download of Teams & Fixtures to cache them)
    func syncFavoriteLeagueData(leagueId: String, sport: String, fromDate: String, toDate: String, completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        var downloadSuccessful = true
        
        let sportType = sport.lowercased()
        
        if sportType == "football" {
            dispatchGroup.enter()
            getFootballTeams(leagueId: leagueId) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            getFootballFixtures(leagueId: leagueId, fromDate: fromDate, toDate: toDate) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
        } 
        else if sportType == "basketball" {
            dispatchGroup.enter()
            getBasketballTeams(leagueId: leagueId) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            getBasketballFixtures(leagueId: leagueId, fromDate: fromDate, toDate: toDate) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
        }
        else if sportType == "cricket" {
            dispatchGroup.enter()
            getCricketTeams(leagueId: leagueId) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            getCricketFixtures(leagueId: leagueId, fromDate: fromDate, toDate: toDate) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
        }
        else if sportType == "tennis" {
            dispatchGroup.enter()
            getTennisFixtures(leagueId: leagueId, fromDate: fromDate, toDate: toDate) { result in
                if case .failure = result { downloadSuccessful = false }
                dispatchGroup.leave()
            }
        }

        // Notify when all background fetches are complete and saved to Core Data
        dispatchGroup.notify(queue: .main) {
            completion(downloadSuccessful)
        }
    }
}