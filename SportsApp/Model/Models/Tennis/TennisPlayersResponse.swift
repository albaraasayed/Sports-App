import Foundation

// MARK: - Root Response
struct TennisPlayersResponse: Codable {
    let success: Int
    let result: [TennisPlayer]?
}

// MARK: - Tennis Player Model
struct TennisPlayer: Codable {
    let player_key: String?
    let player_name: String?
    let player_country: String?
    let player_bday: String?
    let player_logo: String?
    
    // Performance & History Arrays
    let stats: [TennisPlayerStat]?
    let tournaments: [TennisPlayerTournament]?
}

// MARK: - Yearly Performance Stats
struct TennisPlayerStat: Codable {
    let season: String?
    let type: String?         // e.g., "singles" or "doubles"
    let rank: String?
    let titles: String?
    let matches_won: String?
    let matches_lost: String?
    let hard_won: String?
    let hard_lost: String?
    let clay_won: String?
    let clay_lost: String?
    let grass_won: String?
    let grass_lost: String?
}

// MARK: - Historical Tournament Highlights
struct TennisPlayerTournament: Codable {
    let name: String?         // Tournament name e.g., "Wimbledon"
    let season: String?       // Year e.g., "2021"
    let type: String?         // e.g., "singles"
    let surface: String?      // e.g., "grass", "clay", "hard (indoor)"
    let prize: String?        // Financial prize string with local currency symbol
}