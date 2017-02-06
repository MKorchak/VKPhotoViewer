//
//  PhotosTableViewController.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    
    var albumID: Int = 0
    var photosURL: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosURL.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as! PhotoTableViewCell
        cell.setPhotoData(photoURL: photosURL[indexPath.row])

        return cell
    }
 
    private func getPhotos() {
        callMethod(VKRequest(method: "photos.get", parameters: [VK_API_ALBUM_ID: "\(albumID)", VK_API_PHOTO_SIZES: "1"], modelClass: VKPhoto.self))
        callingRequest.debugTiming = true    //156695878
        callingRequest.requestTimeout = 10
        callingRequest.execute(resultBlock: {(response) in
            let jsonResult = response?.json as! NSDictionary
            callingRequest = nil
            print("\(response?.request.requestTiming)")
            let results = jsonResult["items"] as! NSArray
            for result in results {
                let photo = result as AnyObject
                let k = photo.value(forKey: "sizes") as! NSArray
                let m = k[k.count - 1] as AnyObject
                self.photosURL.append(m.value(forKey: "src") as! String)
            }
            OperationQueue.main.addOperation({ () -> Void in
                self.tableView.reloadData()
            })
        }, errorBlock: {(error) in
            print("Error: \(error)")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PhotoViewController
                destinationController.photoURL = photosURL[indexPath.row]
                destinationController.navigationController?.navigationBar.isHidden = false
            }
        }
    }
}
