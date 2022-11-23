import ComposableArchitecture
import Combine
import ContactList
import ContactHeader
import Settings
import UIKit

public class RootViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    private let store = StoreOf<RootFeature>(initialState: .init(), reducer: RootFeature())
    private lazy var headerViewController: ContactHeaderViewController = {
        let controller = ContactHeaderViewController(store: store.scope(state: \.header, action: RootFeature.Action.header))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    private lazy var contactListViewController: ContactListViewController = {
        let controller = ContactListViewController(store: store.scope(state: \.contactList, action: RootFeature.Action.contactList))
        controller.tabBarItem = UITabBarItem(title: "Contacts", image: nil, selectedImage: nil)
        return controller
    }()
    private lazy var settingsViewController: SettingsViewController = {
        let controller = SettingsViewController(
            infoStore: store.scope(state: \.infoSettings, action: RootFeature.Action.infoSettings),
            detailsStore: store.scope(state: \.detailsSettings, action: RootFeature.Action.detailsSettings)
        )
        controller.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        return controller
    }()
    lazy var tabBarViewController = UITabBarController()
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.constrain(verticalStackView)
        add(headerViewController, to: verticalStackView)
        add(tabBarViewController, to: verticalStackView)
        tabBarViewController.viewControllers = [contactListViewController, settingsViewController]
    }
}
