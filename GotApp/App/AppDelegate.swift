import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  private let appFactory: AppFactory = DI()
  private var appCoordinator: Coordinator?
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    constructUI()
    return true
  }

  private func constructUI() {
    let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
    self.window = window
    self.appCoordinator = coordinator

    window.makeKeyAndVisible()
    coordinator.start()
  }
}
