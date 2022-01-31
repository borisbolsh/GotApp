import Foundation

final class ApplicationCoordinator: AppCoordinator {
  private let coordinatorFactory: CoordinatorFactoryImpl
  private let router: Router

  init(router: Router, coordinatorFactory: CoordinatorFactoryImpl) {
    self.router = router
    self.coordinatorFactory = coordinatorFactory
  }

  override func start() {
    runListFlow()
  }

  private func runListFlow() {
    let coordinator = coordinatorFactory.makePersonesCoordinator(router: router)
    self.addDependency(coordinator)
    coordinator.start()
  }
}
