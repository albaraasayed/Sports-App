import Foundation

// MARK: - Root Response
struct TennisLeaguesResponse: Codable {
    let success: Int
    let result: [TennisLeague]?
}

// MARK: - League / Tournament Model
struct TennisLeague: Codable {
    let league_key: String?
    let league_name: String? // Usually represents the city/location of the tournament
    let country_key: String?
    let country_name: String? // In Tennis, this field displays categories like "Challenger Men Singles"
}