
import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    let tableView = UITableView()


    enum CellType {
        case text(String)
        case input(String, String)
    }

    var data: [CellType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mixed Cells"
        view.backgroundColor = .white

        // Заполнение данными
        for i in 1...20 {
            data.append(.text("Static Text \(i)"))
        }
        data.append(.input("Name", "Enter your name"))
        data.append(.input("Email", "Enter your email"))

        // Настройка таблицы
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextCell.self, forCellReuseIdentifier: "TextCell")
        tableView.register(InputCell.self, forCellReuseIdentifier: "InputCell")

        view.addSubview(tableView)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        setupConstraints()
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .zero
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]

        switch item {
        case .text(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(with: text)
            return cell
        case .input(let title, let placeholder):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
            cell.configure(with: title, placeholder: placeholder)
            return cell
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TextCell

class TextCell: UITableViewCell {
    func configure(with text: String) {
        textLabel?.text = text
        textLabel?.font = UIFont.systemFont(ofSize: 16)
    }
}
// MARK: - InputCell
class InputCell: UITableViewCell, UITextFieldDelegate {

    private let titleLabel = UILabel()
    private let textField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect

        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)

        // Установка делегата
        textField.delegate = self

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(with title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }
}
