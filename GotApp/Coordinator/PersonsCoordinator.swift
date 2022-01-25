import Foundation

final class PersonesCoordinator: AppCoordinator {
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showPersones()
    }
    
    private func showPersones() {
        let listPersonesScreen = screenFactory.makeListViewController()
        listPersonesScreen.onSelectCharacter = { [weak self] in self?.showPerson(char: $0) }
        router.setRootModule(listPersonesScreen, hideBar: false)
    }
    
    private func showPerson(char: Character) {
        let personScreen = screenFactory.makeDetailViewController(char: char)
        router.push(personScreen)
    }
}
