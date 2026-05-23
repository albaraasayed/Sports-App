import Foundation

// MARK: - Root Response
struct BasketballFixturesResponse: Codable {
    let success: Int
    let result: [BasketballFixture]?
}

// MARK: - Main Fixture Model
struct BasketballFixture: Codable {
    let event_key: String?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: String?
    let event_away_team: String?
    let away_team_key: String?
    let event_final_result: String?
    let event_quarter: String?
    let event_status: String?
    let country_name: String?
    let league_name: String?
    let league_key: String?
    let league_round: String?
    let league_season: String?
    let event_live: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    
    // Nested Data Objects
    let scores: BasketballQuarterScores?
    let statistics: [BasketballMatchStat]?
    let lineups: BasketballLineupsContainer?
    let player_statistics: BasketballPlayerStatsContainer?
}

// MARK: - Quarter Scores Breakdown
struct BasketballQuarterScores: Codable {
    // Coding keys mapping the exact quarter strings to arrays of scores
    let firstQuarter: [BasketballPeriodScore]?
    let secondQuarter: [BasketballPeriodScore]?
    let thirdQuarter: [BasketballPeriodScore]?
    let fourthQuarter: [BasketballPeriodScore]?
    
    enum CodingKeys: String, CodingKey {
        case firstQuarter = "1stQuarter"
        case secondQuarter = "2ndQuarter"
        case thirdQuarter = "3rdQuarter"
        case fourthQuarter = "4thQuarter"
    }
}

struct BasketballPeriodScore: Codable {
    let score_home: String?
    let score_away: String?
}

// MARK: - Global Match Statistics
struct BasketballMatchStat: Codable {
    let type: String?
    let home: String?
    let away: String?
}

// MARK: - Lineups
struct BasketballLineupsContainer: Codable {
    let home_team: BasketballTeamLineup?
    let away_team: BasketballTeamLineup?
}

struct BasketballTeamLineup: Codable {
    let starting_lineups: [BasketballLineupPlayer]?
    let substitutes: [BasketballLineupPlayer]?
}

struct BasketballLineupPlayer: Codable {
    let player: String?
    let player_id: String?
}

// MARK: - Player Statistics Box Score
struct BasketballPlayerStatsContainer: Codable {
    let home_team: [BasketballDetailedPlayerStat]?
    let away_team: [BasketballDetailedPlayerStat]?
}

struct BasketballDetailedPlayerStat: Codable {
    let player: String?
    let player_id: String?
    let player_assists: String?
    let player_blocks: String?
    let player_defense_rebounds: String?
    let player_field_goals_attempts: String?
    let player_field_goals_made: String?
    let player_freethrows_goals_attempts: String?
    let player_freethrows_goals_made: String?
    let player_minutes: String?
    let player_offence_rebounds: String?
    let player_oncourt: String?
    let player_personal_fouls: String?
    let player_plus_minus: String?
    let player_position: String?
    let player_points: String?
    let player_steals: String?
    let player_threepoint_goals_attempts: String?
    let player_threepoint_goals_made: String?
    let player_total_rebounds: String?
    let player_turnovers: String?
}