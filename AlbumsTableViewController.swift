//
//  AlbumsTableViewController.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albums = [Albums]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.logout))
        getAlbums()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func logout(_ sender: Any) {
        VKSdk.forceLogout()
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Album", for: indexPath) as! AlbumTableViewCell

        cell.setAlbumData(thumbURl: albums[indexPath.row].thumbURL, title: albums[indexPath.row].title)

        return cell
    }
    
    private func getAlbums() {
        callMethod(VKRequest(method: "photos.getAlbums", parameters: [VK_API_NEED_COVERS: "1"], modelClass: VKPhoto.self))
        callingRequest.debugTiming = true    //156695878
        callingRequest.requestTimeout = 10
        callingRequest.execute(resultBlock: {(response) in
            let jsonResult = response?.json as! NSDictionary
            callingRequest = nil
            print("\(response?.request.requestTiming)")
            let results = jsonResult["items"] as! NSArray
            for result in results {
                let album = result as AnyObject
                let page = Albums()
                page.thumbURL = album.value(forKey: "thumb_src") as! String
                page.title = album.value(forKey: "title") as! String
                page.id = album.value(forKey: "id") as! Int
                self.albums.append(page)
            }
            OperationQueue.main.addOperation({ () -> Void in
                self.tableView.reloadData()
            })
        }, errorBlock: {(error) in
            print("Error: \(error)")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PhotosTableViewController
                destinationController.albumID = albums[indexPath.row].id
            }
        }
    }

}
