//
//  PhotoViewController.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeAsynchronousImageDownload(parent: photoImageView, imageURL: photoURL!, activityIndicatorStyle: .white)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.hidesBarsOnTap = false
    }
    
}
