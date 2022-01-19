import UIKit

// TODO: change network layer
final class Network {
    
    static let shared = Network()
    private let BASE_URL = "https://thronesapi.com/api/v2/Characters"
    let cache = NSCache<NSString, UIImage>()
    
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
    
    func fetchImage(
        from urlString: String,
        completion: @escaping(UIImage?) -> Void
    ) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let error = error {
                print("Failed to fetch image with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
           
            self?.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
    

}
