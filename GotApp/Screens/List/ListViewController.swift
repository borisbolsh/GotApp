import UIKit

final class ListViewController: UIViewController {
    
    private var characters = [Character]()
    private var filteredCharacters = [Character]()
    private var inSearchMode = false
    private var searchBar = UISearchBar()

    private let collectionView: UICollectionView
    private let spinner = UIActivityIndicatorView(style: .gray)
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
        self.title = "Game of Thrones"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        configureActivityIndicator()
        configureNavigationBar()
        fetchChars()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        collectionView.frame = view.bounds
    }
    
}

// MARK: Setup UI
extension ListViewController {
    private func setupCollectionView(){
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func configureActivityIndicator() {
        collectionView.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    private func configureNavigationBar() {
        setStatusBar()
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.isTranslucent = true
  
        configureSearchBarButton()
    }

    private func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
    }
    
    func configureSearchBar() {
           searchBar.delegate = self
           searchBar.sizeToFit()
           searchBar.showsCancelButton = true
           searchBar.becomeFirstResponder()

           navigationItem.rightBarButtonItem = nil
           navigationItem.titleView = searchBar
    }
}

// MARK: - Actions
extension ListViewController {
    @objc func showSearchBar() {
        configureSearchBar()
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        configureSearchBarButton()
        inSearchMode = false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredCharacters = characters.filter({ $0.firstName?.lowercased().range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}

// MARK: API
extension ListViewController {
    private func fetchChars() {
        Network.shared.fetchCharacters(){ (characters) in
            DispatchQueue.main.async {
                self.characters = characters
                self.spinner.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredCharacters.count : characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell

        cell.configure(with: inSearchMode ? filteredCharacters[indexPath.row] : characters[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionDelegate
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: change soon
        let controller = DetailViewController()
        controller.configurate(with: inSearchMode ? filteredCharacters[indexPath.row] : characters[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rect = (view.frame.width - 36) / 3
        return CGSize(width: rect, height: rect)
    }
    
}
