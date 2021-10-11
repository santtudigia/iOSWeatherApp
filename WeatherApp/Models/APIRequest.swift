import Foundation

protocol APIEndpoint {
    func endpoint() -> String
    func params() -> String
}

class APIRequest {
    struct ErrorResponse: Codable {
        let status: String
        let code: Int
        let message: String
    }

    enum APIError: Error {
        case invalidEndpoint
        case errorResponseDetected
        case noData
    }
}
