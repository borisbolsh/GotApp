import UIKit

final class DI {
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactory
    
    init() {
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl()
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension DI: AppFactory {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let coordinator = AppCoordinator()
        
        return (window, coordinator)
    }
}

protocol ScreenFactory {
    
    func makeListViewController() -> UIViewController
    func makeDetailViewController() -> UIViewController
    
}

final class ScreenFactoryImpl: ScreenFactory {
  
    func makeListViewController() -> UIViewController {
        let result = ListViewController()
        return result
    }
    
    func makeDetailViewController() -> UIViewController {
        let result = DetailViewController()
        return result
    }
    
}

protocol CoordinatorFactory {
    func makeApplicationCoordinator()
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    func makeApplicationCoordinator() {
        
    }
}

