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
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.backgroundColor = .yellow
        lbl.textAlignment = .left
        lbl.numberOfLines = 4
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureLabels(with model: VideoSearchCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    func configureImage(image: UIImage?) {
        thumbnailImage.image = image
        thumbnailImage.backgroundColor = .gray
    }
    
}

private extension VideoSearchCell {
    func configureSubviews() {
        self.addSubview(thumbnailImage)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4.0 / 5.0).isActive = true
        thumbnailImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0 / 3.0).isActive = true
        thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2.0 / 3.0).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0 / 5.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImage.topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2.0 / 3.0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3.0 / 5.0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
