import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // TODO: Change to coordinator
        let navVC = UINavigationController(rootViewController:ListViewController())
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

