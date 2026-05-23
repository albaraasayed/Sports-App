import Foundation

// MARK: - Root Response
struct FootballFixturesResponse: Codable {
    let success: Int
    let result: [FootballFixture]?
}

// MARK: - Main Fixture Model
struct FootballFixture: Codable {
    let event_key: String?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: String?
    let event_away_team: String?
    let away_team_key: String?
    let event_halftime_result: String?
    let event_final_result: String?
    let event_ft_result: String?
    let event_penalty_result: String?
    let event_status: String?
    let country_name: String?
    let league_name: String?
    let league_key: String?
    let league_round: String?
    let league_season: String?
    let event_live: String?
    let event_stadium: String?
    let event_referee: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_country_key: String?
    let league_logo: String?
    let country_logo: String?
    let event_home_formation: String?
    let event_away_formation: String?
    let fk_stage_key: String?
    let stage_name: String?
    let league_group: String?
    
    // Nested Data Objects
    let goalscorers: [FootballGoalscorer]?
    let substitutes: [FootballSubstitution]?
    let cards: [FootballCard]?
    let lineups: FootballLineupsContainer?
    let statistics: [FootballMatchStat]?
}

// MARK: - Goalscorer
struct FootballGoalscorer: Codable {
    let time: String?
    let home_scorer: String?
    let home_assist: String?
    let away_scorer: String?
    let away_assist: String?
    let score: String?
    let info: String?
}

// MARK: - Substitution
struct FootballSubstitution: Codable {
    let time: String?
    let score: String?
    // Using custom structures to handle dynamic nested objects safely
    let home_scorer: FootballScorerDetails?
    let away_scorer: FootballScorerDetails?
}

struct FootballScorerDetails: Codable {
    let `in`: String?
    let out: String?
}

// MARK: - Card
struct FootballCard: Codable {
    let time: String?
    let home_fault: String?
    let card: String?
    let away_fault: String?
}

// MARK: - Lineups
struct FootballLineupsContainer: Codable {
    let home_team: FootballTeamLineup?
    let away_team: FootballTeamLineup?
}

struct FootballTeamLineup: Codable {
    let starting_lineups: [FootballPlayerLineup]?
    let substitutes: [FootballPlayerLineup]?
    let coaches: [FootballCoach]?
    let missing_players: [FootballPlayerLineup]?
}

struct FootballPlayerLineup: Codable {
    let player: String?
    let player_number: String?
    let player_position: String?
    let player_country: String?
    let player_key: String?
}

struct FootballCoach: Codable {
    let coache: String? // Kept API's exact typo "coache"
    let coache_country: String?
}

// MARK: - Match Statistics
struct FootballMatchStat: Codable {
    let type: String?
    let home: String?
    let away: String?
}