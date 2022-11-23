import Foundation
import UIKit
import ComposableArchitecture
import Combine
import SharedModels

public class ContactView: UIView {
    private var cancellables = Set<AnyCancellable>()
    private var store: StoreOf<ContactFeature>
    private var viewStore: ViewStoreOf<ContactFeature>

    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.alignment = .leading
        view.axis = .horizontal
        return view
    }()
    lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.numberOfLines = 0
        view.font = .preferredFont(forTextStyle: .title2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(store: StoreOf<ContactFeature>) {
        self.store = store
        self.viewStore = ViewStore(store)
        super.init(frame: .zero)
        setupView()
        setupBindings()
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        constrain(horizontalStackView, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        horizontalStackView.addArrangedSubview(photoImageView)
        horizontalStackView.addArrangedSubview(nameLabel)
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 30),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor)
        ])
    }

    private func setupBindings() {
            viewStore.publisher.contact
                .sink { [weak self] contact in
                self?.nameLabel.text = "\(contact.firstName) \(contact.lastName)"
            }
            .store(in: &cancellables)
        viewStore.publisher.photoData
            .sink { [weak self] data in
                self?.photoImageView.image = data.map { UIImage(data: $0) ?? .init() }
            }
            .store(in: &cancellables)
    }
}
