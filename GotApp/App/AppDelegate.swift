import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // TODO: Change to coordinator
        let listVC = ListViewController(networkManager: networkManager)
        let navVC = UINavigationController(rootViewController: listVC)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

