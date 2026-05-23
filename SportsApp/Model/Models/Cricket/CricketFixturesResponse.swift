import Foundation

// MARK: - Root Response
struct CricketFixturesResponse: Codable {
    let success: Int
    let result: [CricketFixture]?
}

// MARK: - Main Fixture Model
struct CricketFixture: Codable {
    let event_key: String?
    let event_date_start: String?
    let event_date_stop: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: String?
    let event_away_team: String?
    let away_team_key: String?
    let event_service_home: String?
    let event_service_away: String?
    let event_home_final_result: String?
    let event_away_final_result: String?
    let event_home_rr: String?
    let event_away_rr: String?
    let event_status: String?
    let event_status_info: String?
    let country_name: String?
    let league_name: String?
    let league_key: String?
    let league_round: String?
    let league_season: String?
    let event_live: String?
    let event_type: String?
    let event_toss: String?
    let event_man_of_match: String?
    let event_stadium: String?
    let event_home_team_logo: String?
    let event_away_team_logo: String?
    
    // Dynamic Dictionary Objects mapped to adapt to custom Innings string keys
    let scorecard: [String: [CricketScorecardEntry]]?
    let comments: [String: [CricketCommentEntry]]?
    let lineups: CricketLineupsContainer?
    let wickets: [String: [CricketWicketEntry]]?
    let extra: [String: CricketExtraDetails]?
}

// MARK: - Scorecard Entry
struct CricketScorecardEntry: Codable {
    let innings: String?
    let player: String?
    let type: String?   // e.g., "Batsman", "Bowler"
    let status: String? // e.g., "lbw b Bird"
    let R: String?      // Runs
    let B: String?      // Balls faced
    let Min: String?    // Minutes batted
    let O: String?      // Overs bowled
    let M: String?      // Maidens bowled
    let W: String?      // Wickets taken
    let SR: String?     // Strike Rate
    let ER: String?     // Economy Rate
    
    enum CodingKeys: String, CodingKey {
        case innings, player, type, status, R, B, Min, O, M, W, SR, ER
        case four_s = "4s"
        case six_s = "6s"
    }
    let four_s: String? // Mapped safely from raw property key "4s"
    let six_s: String?  // Mapped safely from raw property key "6s"
}

// MARK: - Comment Entry
struct CricketCommentEntry: Codable {
    let innings: String?
    let balls: String?
    let overs: String?
    let ended: String?
    let runs: String?
    let post: String?
}

// MARK: - Lineups
struct CricketLineupsContainer: Codable {
    let home_team: CricketTeamLineup?
    let away_team: CricketTeamLineup?
}

struct CricketTeamLineup: Codable {
    let starting_lineups: [CricketLineupPlayer]?
}

struct CricketLineupPlayer: Codable {
    let player: String?
    let player_country: String?
}

// MARK: - Wicket Entry
struct CricketWicketEntry: Codable {
    let innings: String?
    let fall: String?
    let balwer: String? // Kept API's exact typo "balwer" (bowler)
    let batsman: String?
    let score: String?
}

// MARK: - Extra Innings Details
struct CricketExtraDetails: Codable {
    let innings: String?
    let nr: String?
    let text: String?
    let total_overs: String?
    let total: String?
    let percent_over: String?
}