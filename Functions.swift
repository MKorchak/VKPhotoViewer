//
//  Functions.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import Foundation

var SCOPE: [Any]? = nil

var callingRequest: VKRequest!

func callMethod(_ method: VKRequest) {
    callingRequest = method
}

func makeAsynchronousImageDownload(parent: UIImageView, imageURL: String, activityIndicatorStyle: UIActivityIndicatorViewStyle) {
    parent.setShowActivityIndicator(true)
    parent.setIndicatorStyle(activityIndicatorStyle)
    parent.sd_setImage(with: URL(string: imageURL))
}

func displayAlert(delegate: UIViewController, title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    
    let defaultButton = UIAlertAction(title: buttonTitle, style: .default)
    
    alert.addAction(defaultButton)
    delegate.present(alert, animated: true) {
    }
}
