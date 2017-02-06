//
//  AlbumTableViewCell.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAlbumData(thumbURl: String, title: String) {
        titleLabel.text = title
        makeAsynchronousImageDownload(parent: thumbImageView, imageURL: thumbURl, activityIndicatorStyle: .gray)
    }

}
