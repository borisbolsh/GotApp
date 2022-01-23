import Foundation
import UIKit.UIImage

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    static let environment: NetworkEnvironment = .production
    let router = Router<GOTApi>()

    private init() {}
    
    func getCharacters(
        completion: @escaping (_ characters: [Character]?,_ error: String?)->()
    ){
        router.request(.characters) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(
                            [Character].self,
                            from: responseData
                        )
                        completion(apiResponse,nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getImage(
        from imgStr: String,
        completion: @escaping(UIImage?,_ error: String?) -> Void
    ) {
    
        router.request(.imageChar(imgName: imgStr)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let image = UIImage(data: responseData)
                    completion(image,nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
        
    
    }
    
    private func handleNetworkResponse(
        _ response: HTTPURLResponse
    ) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
