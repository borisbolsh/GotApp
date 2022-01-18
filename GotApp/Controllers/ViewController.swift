import UIKit

// TODO: change to collection view
class ViewController: UIViewController {
    
    private var characters = [Character]()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        fetchChars()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

// MARK: Setup UI
extension ViewController {
    private func setupTableView(){
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

// MARK: API
extension ViewController {
    private func fetchChars() {
        Service.shared.fetchCharacters(){ (characters) in
            DispatchQueue.main.async {
                self.characters = characters
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].firstName
        return cell
    }
    
}
