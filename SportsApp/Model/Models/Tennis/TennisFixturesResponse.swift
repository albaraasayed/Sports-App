import Foundation

// MARK: - Root Response
struct TennisFixturesResponse: Codable {
    let success: Int
    let result: [TennisFixture]?
}

// MARK: - Main Fixture Model
struct TennisFixture: Codable {
    let event_key: String?
    let event_date: String?
    let event_time: String?
    let event_first_player: String?
    let first_player_key: String?
    let event_second_player: String?
    let second_player_key: String?
    let event_final_result: String?
    let event_game_result: String?
    let event_serve: String?
    let event_winner: String? // e.g., "First Player" or null
    let event_status: String? // e.g., "Finished" or ""
    let country_name: String?
    let league_name: String?
    let league_key: String?
    let league_round: String?
    let league_season: String?
    let event_live: String?
    let event_first_player_logo: String?
    let event_second_player_logo: String?
    
    // Nested Data Objects
    let pointbypoint: [TennisPointByPoint]?
    let scores: [TennisSetScore]?
}

// MARK: - Point By Point Breakdown
struct TennisPointByPoint: Codable {
    let set_number: String?      // e.g., "Set 1"
    let number_game: String?     // e.g., "1"
    let player_served: String?   // e.g., "First Player"
    let serve_winner: String?    // e.g., "First Player"
    let serve_lost: String?
    let score: String?           // Game score e.g., "1 - 0"
    let points: [TennisPointDetail]?
}

// MARK: - Individual Point Details
struct TennisPointDetail: Codable {
    let number_point: String?    // e.g., "1"
    let score: String?           // Live point score e.g., "15 - 0"
    let break_point: String?
    let set_point: String?
    let match_point: String?
}

// MARK: - Set Scores
struct TennisSetScore: Codable {
    let score_first: String?     // First player's games in this set
    let score_second: String?    // Second player's games in this set
    let score_set: String?       // The set number e.g., "1", "2"
}