import Foundation
import UIKit
import ComposableArchitecture
import Combine
import Core
import SharedModels

public class ContactListViewController: UIViewController, UITableViewDelegate {
    enum Section: CaseIterable {
        case main
    }
    private var cancellables = Set<AnyCancellable>()
    private let cellIdentifier = "ContactListViewCell"
    private let store: StoreOf<ContactListFeature>
    private lazy var viewStore = ViewStore(store)
    private var contactListView: ContactListView? { view as? ContactListView }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(store: StoreOf<ContactListFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {
        view = ContactListView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }

    private func setupView() {
        contactListView?.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        contactListView?.tableView.dataSource = dataSource
        contactListView?.tableView.delegate = self
    }

    private func setupBindings() {
        viewStore.publisher.isLoading
            .sink { [weak self] isLoading in
                self?.contactListView?.activityIndicator.isHidden = !isLoading
            }
            .store(in: &cancellables)
        viewStore.publisher.contacts
            .sink { [weak self] in
                var snapshot = NSDiffableDataSourceSnapshot<Section, ContactFeature.State>()
                snapshot.appendSections(Section.allCases)
                snapshot.appendItems($0.elements, toSection: .main)
                self?.dataSource?.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }

    lazy var dataSource: UITableViewDiffableDataSource<Section, ContactFeature.State>? = {
        guard let tableView = contactListView?.tableView else { return nil }
        return UITableViewDiffableDataSource(tableView: tableView) { [weak self] tableView, indexPath, contact -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            let contactView = ContactView(
                store: self.store.scope(
                    state: { $0.contacts[indexPath.row] },
                    action: { .contact(id: contact.id, action: $0) }
                )
            )
            cell.set(contentView: contactView)
            return cell
        }
    }()

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let contact = viewStore.contacts.elements[indexPath.row]
        viewStore.send(.contact(id: contact.id, action: .onAppear))
    }
}

class ContactListView: UIView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44.0
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
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
        constrain(tableView)
        constrain(activityIndicator)
    }
}
