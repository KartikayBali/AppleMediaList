//
//  MediaTableViewCell.swift
//  AppleMediaList
//
//  Created by Bali on 19/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
  
  static let CellIdentifier = "MediaTableViewCellIdentifier"
  static let CellHeight: CGFloat = 100
  
  let mediaImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.layer.cornerRadius = 6
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = UIColor.black
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    label.clipsToBounds = true
    return label
  }()
  
  let subTitleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 14)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.clipsToBounds = true
    return label
  }()
  
  var media: Media! {
    didSet {
      loadCell()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupCell()
  }
  
  private func setupCell() {
    contentView.addSubview(mediaImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subTitleLabel)

    NSLayoutConstraint.activate(getImageViewConstraints() + getTitleLabelConstraints() + getSubtitleLabelConstraints())
  }
  
  private func getImageViewConstraints() -> [NSLayoutConstraint] {
    return [
      mediaImageView.widthAnchor.constraint(equalToConstant: type(of: self).CellHeight - 20),
      mediaImageView.heightAnchor.constraint(equalToConstant: type(of: self).CellHeight - 20),
      mediaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mediaImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
  }
  
  private func getTitleLabelConstraints() -> [NSLayoutConstraint] {
    return [
      titleLabel.leadingAnchor.constraint(equalTo: mediaImageView.trailingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      titleLabel.topAnchor.constraint(equalTo: mediaImageView.topAnchor)
    ]
  }
  
  private func getSubtitleLabelConstraints() -> [NSLayoutConstraint] {
    return [
      subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      subTitleLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 10),
      subTitleLabel.bottomAnchor.constraint(equalTo: mediaImageView.bottomAnchor)
    ]
  }
  
  private func loadCell() {
    mediaImageView.sd_setImage(with: URL(string: media.artworkUrl100), completed: nil)
    titleLabel.text = media.name
    subTitleLabel.text = media.kind
  }
}
