import Combine
import ComposableArchitecture
import Core
import UIKit

public class SettingsViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let infoStore: StoreOf<InfoSettingsFeature>
    private let detailsStore: StoreOf<DetailsSettingsFeature>
    private lazy var infoViewStore = ViewStore(infoStore)
    private lazy var detailsViewStore = ViewStore(detailsStore)
    private var settingsView: SettingsView? { view as? SettingsView }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(infoStore: StoreOf<InfoSettingsFeature>, detailsStore: StoreOf<DetailsSettingsFeature>) {
        self.infoStore = infoStore
        self.detailsStore = detailsStore
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {
        view = SettingsView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        settingsView?.firstNameItemView.itemLabel.text = "First name"
        settingsView?.lastNameItemView.itemLabel.text = "Last name"
        settingsView?.phoneItemView.itemLabel.text = "Phone"
        settingsView?.emailItemView.itemLabel.text = "Email"
        settingsView?.addressItemView.itemLabel.text = "Address"
        settingsView?.photoItemView.itemLabel.text = "Photo"
        settingsView?.statusMessageItemView.itemLabel.text = "Status message"
        settingsView?.jobTitleItemView.itemLabel.text = "Job title"
    }
}

class SettingsView: UIView {
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.axis = .vertical
        return view
    }()
    lazy var firstNameItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var lastNameItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var phoneItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var emailItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var addressItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var photoItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var statusMessageItemView: SettingsItemView = {
        let view = SettingsItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var jobTitleItemView: SettingsItemView = {
        let view = SettingsItemView()
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
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(firstNameItemView)
        verticalStackView.addArrangedSubview(lastNameItemView)
        verticalStackView.addArrangedSubview(phoneItemView)
        verticalStackView.addArrangedSubview(emailItemView)
        verticalStackView.addArrangedSubview(addressItemView)
        verticalStackView.addArrangedSubview(photoItemView)
        verticalStackView.addArrangedSubview(statusMessageItemView)
        verticalStackView.addArrangedSubview(jobTitleItemView)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
