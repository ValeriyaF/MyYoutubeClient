import UIKit

final class VideoSearchView: UIView {
    
    private let tableView = UITableView(frame: .zero)
    private let searchTextField: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let cellReuseID = "VideoSearchCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView() // rename
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .white
        self.addSubview(tableView)
        self.addSubview(searchTextField)
        self.addSubview(searchButton)
        tableView.register(VideoSearchCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let parent = safeAreaLayoutGuide
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        searchTextField.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 4.0 / 6.0).isActive = true
        searchTextField.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 1.0 / 15.0).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        
        searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor).isActive = true
        searchButton.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        searchButton.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    }
}

extension VideoSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! VideoSearchCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.videoSearchCellTableViewHeightForRow
    }
}

extension VideoSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
