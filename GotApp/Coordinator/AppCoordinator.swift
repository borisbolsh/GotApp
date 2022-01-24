import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
   
    func start() {
        
    }
    
}

