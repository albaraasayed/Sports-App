import Foundation

// MARK: - Root Response
struct CricketLeaguesResponse: Codable {
    let success: Int
    let result: [CricketLeague]?
}

// MARK: - League Model
struct CricketLeague: Codable {
    let league_key: String?
    let league_name: String?
    let league_year: String?
}