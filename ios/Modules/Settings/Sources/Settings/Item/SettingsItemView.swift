import Combine
import ComposableArchitecture
import Core
import UIKit

class SettingsItemView: UIView {
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.alignment = .firstBaseline
        view.axis = .horizontal
        return view
    }()
    lazy var itemLabel: UILabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var itemTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
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
        constrain(horizontalStackView)
        horizontalStackView.addArrangedSubview(itemLabel)
        horizontalStackView.addArrangedSubview(itemTextField)
    }
}
