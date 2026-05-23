import Foundation

// MARK: - Root Response
struct FootballTeamsResponse: Codable {
    let success: Int
    let result: [FootballTeam]?
}

// MARK: - Team Model
struct FootballTeam: Codable {
    let team_key: String?
    let team_name: String?
    let team_logo: String?
    let players: [FootballPlayer]?
}

// MARK: - Player Model
struct FootballPlayer: Codable {
    let player_key: Int? // Notice: Numeric ID from the API
    let player_name: String?
    let player_number: String?
    let player_country: String?
    let player_type: String? // e.g., "Goalkeepers", "Defenders"
    let player_age: String?
    let player_match_played: String?
    let player_goals: String?
    let player_yellow_cards: String?
    let player_red_cards: String?
    let player_image: String?
}