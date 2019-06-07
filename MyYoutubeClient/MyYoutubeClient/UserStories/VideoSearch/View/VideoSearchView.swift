import UIKit

final class VideoSearchView: UIView {
    
    internal var searchTextAppearHandler: ((_ text: String?) -> Void)?
    internal var cellClickHandler: ((_ item: VideoDetailsDataToShare) -> Void)?
//    internal var loadImageForCellHeandler: ((_ index: Int) -> Void)?
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.color = .red
        return indicator
    }()
    
    private let cellReuseID = "VideoSearchCell"
    private var videoList: [Item] = []
    private var currentImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView() // rename
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadVideoList() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func endLoadVideoLest() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func updateSearchResults(withNewResults data: YoutubeSearchApiResponse) {
        videoList.removeAll()
        videoList += data.items ?? []
        tableView.reloadData()
    }

}

private extension VideoSearchView {
    func configureView() {
        self.backgroundColor = .white
        self.addSubview(tableView)
        self.addSubview(searchTextField)
        self.addSubview(searchButton)
        tableView.addSubview(activityIndicator)
        
        tableView.register(VideoSearchCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked(_ :)), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let parent = safeAreaLayoutGuide
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
        
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
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchTextAppearHandler?(searchTextField.text)
    }
}

extension VideoSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! VideoSearchCell
        cell.configureLabels(with: VideoSearchCellModel(snippet: videoList[indexPath.row].snippet))
//        self.loadImageForCellHeandler?(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstants.videoSearchCellTableViewHeightForRow
    }
    
}

extension VideoSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        cellClickHandler?(VideoDetailsDataToShare(model: videoList[indexPath.row]))
    }
}
