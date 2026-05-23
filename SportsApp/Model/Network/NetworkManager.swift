import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    /// Generic fetch method that automatically decodes any Codable response structure
    func fetchData(
        from baseURL: String,
        methodName: String,
        additionalParams: [String: Any] = [:],
        completion: @escaping (Result) -> Void
    ) {
        // 1. Build universal parameters including the secure API Key
        var parameters: [String: Any] = [
            "met": methodName,
            "APIkey": APIConfig.apiKey
        ]
        
        // Merge sport-specific filters (like leagueId, teamId, from/to dates)
        for (key, value) in additionalParams {
            parameters[key] = value
        }
        
        // 2. Execute network request via Alamofire
        AF.request(baseURL, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}