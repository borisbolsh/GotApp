import UIKit

final class CollectionViewCell: UICollectionViewCell {
  static let identifier = "CollectionViewCell"

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.tintColor = .white
    imageView.image = UIImage(named: "logo")
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  var imageVi: Int = 0 {
    didSet {
      print("Hello")
    }
  }


  private let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    contentView.backgroundColor = UIColor(named: "tileColor")
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 8
    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  private func configureLayout() {
    contentView.addSubview(label)
    contentView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: label.topAnchor),

      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      label.heightAnchor.constraint(equalToConstant: 22),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = nil
    imageView.image = UIImage(named: "logo")
  }

  func configure(with char: Character) {
    if char.firstName == "" {
      label.text = "Don't know"
    } else {
      label.text = char.firstName
    }

    NetworkManager.shared.getImage(from: char.image) { image, _ in
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }
  }
}
