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
  
  let mediaImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = UIColor.black
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 22)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.clipsToBounds = true
    return label
  }()
  
  let subTitleLabel: UILabel = {
    let label = UILabel(frame: .zero)
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
      mediaImageView.widthAnchor.constraint(equalToConstant: 80),
      mediaImageView.heightAnchor.constraint(equalToConstant: 80),
      mediaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      mediaImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
  }
  
  private func getTitleLabelConstraints() -> [NSLayoutConstraint] {
    return [
      titleLabel.leadingAnchor.constraint(equalTo: mediaImageView.trailingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
      titleLabel.topAnchor.constraint(equalTo: mediaImageView.topAnchor)
    ]
  }
  
  private func getSubtitleLabelConstraints() -> [NSLayoutConstraint] {
    return [
      subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
    ]
  }
  
  private func loadCell() {
    mediaImageView.sd_setImage(with: URL(string: media.artworkUrl100), completed: nil)
    titleLabel.text = media.artistName
    subTitleLabel.text = media.name
  }
}
