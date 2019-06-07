import UIKit
import WebKit

final class VideoDetailsView: UIView {
    
    private let vebView = WKWebView(frame: .zero)
    private let titleLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .green
        lbl.textAlignment = .left
        return lbl
    }()
    private let chanelLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = .green
        lbl.textAlignment = .left
        return lbl
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureVideo(with model: VideoDetailsDataToShare) {
        titleLabel.text = model.title
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoId)") else { //add error alert or smth
            return
        }
        vebView.load(URLRequest(url: url))
    }
    
}

private extension VideoDetailsView {
    func configureView() {
        
        self.addSubview(vebView)
        self.addSubview(titleLabel)
        self.addSubview(chanelLabel)
        
        vebView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        chanelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vebView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2.0 / 5.0).isActive = true
        vebView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        vebView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        vebView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: vebView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0 / 20.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        chanelLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
        chanelLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        chanelLabel.to
    }
}
