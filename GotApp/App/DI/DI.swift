import UIKit

final class DI {
  fileprivate let screenFactory: ScreenFactory
  fileprivate let coordinatorFactory: CoordinatorFactory

  init() {
    screenFactory = ScreenFactoryImpl()
    coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
  }
}

protocol AppFactory {
  func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension DI: AppFactory {
  func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
    let window = UIWindow()
    let rootVC = UINavigationController()
    let router = RouterImp(rootController: rootVC)
    let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
    window.rootViewController = rootVC
    return (window, cooridnator)
  }
}

protocol ScreenFactory {
  func makeListViewController() -> ListViewController
  func makeDetailViewController(char: Character) -> DetailViewController
}

final class ScreenFactoryImpl: ScreenFactory {
  func makeListViewController() -> ListViewController {
    let result = ListViewController()
    return result
  }

  func makeDetailViewController(char: Character) -> DetailViewController {
    let result = DetailViewController(char: char)
    return result
  }
}

protocol CoordinatorFactory {
  func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
  func makePersonesCoordinator(router: Router) -> PersonesCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
  private let screenFactory: ScreenFactory

  fileprivate init(screenFactory: ScreenFactory) {
    self.screenFactory = screenFactory
  }

  func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
    return ApplicationCoordinator(router: router, coordinatorFactory: self)
  }

  func makePersonesCoordinator(router: Router) -> PersonesCoordinator {
    return PersonesCoordinator(router: router, screenFactory: screenFactory)
  }
}
