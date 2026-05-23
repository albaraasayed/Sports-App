import Foundation

// MARK: - Root Response
struct BasketballLeaguesResponse: Codable {
    let success: Int
    let result: [BasketballLeague]?
}

// MARK: - League Model
struct BasketballLeague: Codable {
    let league_key: String?
    let league_name: String?
    let country_key: String?
    let country_name: String?
}