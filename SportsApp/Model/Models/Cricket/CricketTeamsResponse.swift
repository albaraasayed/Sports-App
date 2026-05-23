import Foundation

// MARK: - Root Response
struct CricketTeamsResponse: Codable {
    let success: Int
    let result: [CricketTeam]?
}

// MARK: - Team Model
struct CricketTeam: Codable {
    let team_key: String?
    let team_name: String?
    let team_logo: String?
}