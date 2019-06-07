import UIKit
import WebKit

final class VideoDetailsView: UIView {
    
    private let webView = WKWebView(frame: .zero)

    private lazy var labelsStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
//        sv.spacing = 15
        sv.distribution = .fillEqually
        return sv
    }()
    private let titleLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.7
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .left
        return lbl
    }()
    private let chanelLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.7
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .left
        return lbl
    }()
    private let tagslLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        lbl.minimumScaleFactor = 0.7
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .left
        return lbl
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.color = .red
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureVideoInfo(with model: VideoDetailsDataToShare) {
        titleLabel.text = model.title
        chanelLabel.text = model.channelTitle
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoId)") else { //add error alert or smth
            return
        }
        webView.load(URLRequest(url: url)) 
    }
    
    func configureTagsLabel(with tags: [String]) {
        tagslLabel.text = "Tags: \(tags.joined(separator: ", "))"
    }
    
}

private extension VideoDetailsView {
    func configureView() {
        
        self.addSubview(webView)
        self.addSubview(labelsStackView)
        self.addSubview(tagslLabel)
        configureLabelsStackView()
        configureVebView()
        
        tagslLabel.translatesAutoresizingMaskIntoConstraints = false
        tagslLabel.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor).isActive = true
        tagslLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tagslLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func configureVebView() {
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        webView.addSubview(activityIndicator)
        webView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        webView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2.0 / 5.0).isActive = true
        webView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        webView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 5.0).isActive = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func configureLabelsStackView() {
        labelsStackView.addSubview(titleLabel)
        labelsStackView.addSubview(chanelLabel)
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        labelsStackView.topAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        labelsStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0 / 10.0).isActive = true
        labelsStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(chanelLabel)
    }
}

extension VideoDetailsView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
