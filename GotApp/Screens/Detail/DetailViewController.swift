import UIKit

final class DetailViewController: UIViewController {
    
    private let personeImage = UIImageView()
    private let nameLabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Person name"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    func configurate(with char: Character){
        self.nameLabel.text = char.firstName
        self.title = char.fullName
        
        Network.shared.fetchImage(from: char.imageUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.personeImage.image = image
            }
        }
    }
    
}

// MARK: Setup UI
extension DetailViewController {
    
    private func style() {
        personeImage.translatesAutoresizingMaskIntoConstraints = false
        personeImage.backgroundColor = .blue
        personeImage.contentMode = .scaleAspectFill
        personeImage.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(personeImage)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            personeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight),
            personeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personeImage.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            
            nameLabel.topAnchor.constraint(equalTo: personeImage.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
 
    }
}


