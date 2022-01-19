import UIKit

final class DetailViewController: UIViewController {
    
    private let personeImage = UIImageView()
    
    private let firstNameHeading = UILabel()
    private let firstNameLabel = UILabel()
    private let firstNameStackView = UIStackView()
  
    private let lastNameHeading = UILabel()
    private let lastNameLabel = UILabel()
    private var lastNameStackView = UIStackView()
    
    private let titleHeading = UILabel()
    private let titleLabel = UILabel()
    private var titleStackView = UIStackView()
    
    private let familyHeading = UILabel()
    private let familyLabel = UILabel()
    private var familyStackView = UIStackView()
    
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
        self.title = char.fullName
        self.firstNameLabel.text = char.firstName
        self.lastNameLabel.text = char.lastName
        self.titleLabel.text = char.title
        self.familyLabel.text = char.family

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
        
        firstNameHeading.translatesAutoresizingMaskIntoConstraints = false
        firstNameHeading.numberOfLines = 0
        firstNameHeading.textAlignment = .left
        firstNameHeading.text = "First name:"
        firstNameHeading.font = .systemFont(ofSize: 15, weight: .regular)
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.numberOfLines = 0
        firstNameLabel.textAlignment = .right
        firstNameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        firstNameStackView.translatesAutoresizingMaskIntoConstraints = false
        firstNameStackView.axis = .horizontal
        firstNameStackView.alignment = .fill
        firstNameStackView.spacing = 10
        firstNameStackView.addArrangedSubview(firstNameHeading)
        firstNameStackView.addArrangedSubview(firstNameLabel)
        firstNameStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        firstNameStackView.isLayoutMarginsRelativeArrangement = true
        
        lastNameHeading.translatesAutoresizingMaskIntoConstraints = false
        lastNameHeading.numberOfLines = 0
        lastNameHeading.textAlignment = .left
        lastNameHeading.text = "Last name:"
        lastNameHeading.font = .systemFont(ofSize: 15, weight: .regular)
        
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.numberOfLines = 0
        lastNameLabel.textAlignment = .right
        lastNameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        lastNameStackView.translatesAutoresizingMaskIntoConstraints = false
        lastNameStackView.axis = .horizontal
        lastNameStackView.alignment = .fill
        lastNameStackView.spacing = 10
        lastNameStackView.addArrangedSubview(lastNameHeading)
        lastNameStackView.addArrangedSubview(lastNameLabel)
        lastNameStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        lastNameStackView.isLayoutMarginsRelativeArrangement = true
        
        titleHeading.translatesAutoresizingMaskIntoConstraints = false
        titleHeading.numberOfLines = 0
        titleHeading.textAlignment = .left
        titleHeading.text = "Title:"
        titleHeading.font = .systemFont(ofSize: 15, weight: .regular)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .right
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.alignment = .fill
        titleStackView.spacing = 10
        titleStackView.addArrangedSubview(titleHeading)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleStackView.isLayoutMarginsRelativeArrangement = true
        
        familyHeading.translatesAutoresizingMaskIntoConstraints = false
        familyHeading.numberOfLines = 0
        familyHeading.textAlignment = .left
        familyHeading.text = "Family:"
        familyHeading.font = .systemFont(ofSize: 15, weight: .regular)
        
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        familyLabel.numberOfLines = 0
        familyLabel.textAlignment = .right
        familyLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        familyStackView.translatesAutoresizingMaskIntoConstraints = false
        familyStackView.axis = .horizontal
        familyStackView.alignment = .fill
        familyStackView.spacing = 10
        familyStackView.addArrangedSubview(familyHeading)
        familyStackView.addArrangedSubview(familyLabel)
        familyStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        familyStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    private func layout() {
        view.backgroundColor = UIColor(named: "tileColor")
        view.addSubview(personeImage)
        view.addSubview(firstNameStackView)
        view.addSubview(lastNameStackView)
        view.addSubview(titleStackView)
        view.addSubview(familyStackView)
        
        let padding: CGFloat = 40
        
        NSLayoutConstraint.activate([
            personeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight),
            personeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personeImage.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            
            firstNameStackView.topAnchor.constraint(equalTo: personeImage.bottomAnchor, constant: 10),
            firstNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstNameStackView.heightAnchor.constraint(equalToConstant: padding),
            
            lastNameStackView.topAnchor.constraint(equalTo: firstNameStackView.bottomAnchor),
            lastNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lastNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lastNameStackView.heightAnchor.constraint(equalToConstant: padding),
            
            titleStackView.topAnchor.constraint(equalTo: lastNameStackView.bottomAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleStackView.heightAnchor.constraint(equalToConstant: padding),
            
            familyStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            familyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            familyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            familyStackView.heightAnchor.constraint(equalToConstant: padding),

        ])
        
    }
}


