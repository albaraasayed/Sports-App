import Foundation

// MARK: - Root Response
struct FootballLeaguesResponse: Codable {
    let success: Int
    let result: [FootballLeague]?
}

// MARK: - League Model
struct FootballLeague: Codable {
    let league_key: String?
    let league_name: String?
    let country_key: String?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}