import UIKit

// TODO: change network layer
final class Service {
    
    static let shared = Service()
    private let BASE_URL = "https://thronesapi.com/api/v2/Characters"

    private init() {}
    
    func fetchCharacters(completion: @escaping ([Character]) -> ()) {
         
        guard let url = URL(string: BASE_URL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Character].self, from: data)
                completion(characters)
            } catch let error {
                print("Failed to create json with error: ", error.localizedDescription)
            }
            
        }.resume()
    }
    
    

}
