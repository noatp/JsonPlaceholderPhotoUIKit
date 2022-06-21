//
//  PhotoTableViewCell.swift
//  JsonPlaceholderPhotoUIKit
//
//  Created by Toan Pham on 6/20/22.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    var photo: Photo? {
        didSet {
            guard let photo = photo,
                  let thumbnailUrl = photo.thumbnailUrl
            else {
                return
            }

            remoteImageView.sd_setImage(with: URL(string: thumbnailUrl))
            titleLabel.text = photo.title
        }
    }
    private let remoteImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        let subviews = [remoteImageView, titleLabel]
        for subview in subviews {
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        remoteImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        remoteImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        remoteImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        remoteImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        remoteImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: remoteImageView.trailingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

}
