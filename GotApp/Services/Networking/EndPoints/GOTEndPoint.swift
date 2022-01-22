import Foundation

enum NetworkEnvironment {
    case production
}

public enum GOTApi {
    case characters
    case character(id: Int)
    case imageChar(imgName: String)
}

extension GOTApi: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://thronesapi.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .character(let id):
            return "api/v2/characters/\(id)"
        case .characters:
            return "api/v2/characters"
        case .imageChar(let imgName):
            return "assets/images/\(imgName)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .characters,
             .imageChar:
            return .request
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

