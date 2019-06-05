import UIKit

final class VideoSearchCell: UITableViewCell {
    
    private let thumbnailImage: UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.layer.masksToBounds = true
        imgView.backgroundColor = .red
        return imgView
    }()
    private let titleLabel: UILabel = {
       let lbl = UILabel(frame: .zero)
        lbl.backgroundColor = .green
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureSubviews() {
        self.addSubview(thumbnailImage)
        self.addSubview(titleLabel)
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4.0 / 5.0).isActive = true
        thumbnailImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0 / 3.0).isActive = true
        thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2.0 / 3.0).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4.0 / 5.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImage.topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
