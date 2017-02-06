//
//  PhotoTableViewCell.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPhotoData(photoURL: String) {
        makeAsynchronousImageDownload(parent: photo, imageURL: photoURL, activityIndicatorStyle: .gray)
    }

}
