import Foundation
import UIKit
import ComposableArchitecture
import Combine
import Core

public class ContactHeaderViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let store: StoreOf<ContactHeaderFeature>
    private lazy var viewStore = ViewStore(store)
    private var headerView: ContactHeaderView? { view as? ContactHeaderView }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(store: StoreOf<ContactHeaderFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {
        view = ContactHeaderView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewStore.send(.onAppear)
    }

    private func setupBindings() {
        viewStore.publisher.isLoading
            .sink { [weak self] isLoading in
                self?.headerView?.verticalStackView.isHidden = isLoading
            }
            .store(in: &cancellables)
        viewStore.publisher.user
            .sink { [weak self] user in
                self?.headerView?.nameLabel.text = user.map { "Hi \($0.firstName)!" }
            }
            .store(in: &cancellables)
        viewStore.publisher.photoData
            .sink { [weak self] data in
                self?.headerView?.photoImageView.image = data.map { UIImage(data: $0) ?? .init() }
            }
            .store(in: &cancellables)
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.viewStore.send(.onAppear)
            }
            .store(in: &cancellables)
    }
}

class ContactHeaderView: UIView {
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.axis = .horizontal
        return view
    }()
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .preferredFont(forTextStyle: .title2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        constrain(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(photoImageView)
        horizontalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(dividerView)
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        verticalStackView.setCustomSpacing(8, after: horizontalStackView)
    }
}
