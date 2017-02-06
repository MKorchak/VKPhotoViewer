//
//  ViewController.swift
//  VKPhotoViewer
//
//  Created by Misha Korchak on 06.02.17.
//  Copyright © 2017 Misha Korchak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate, UIWebViewDelegate, UIAlertViewDelegate {
    
    @IBAction func Authorization(_ sender: Any) {
        VKSdk.authorize(SCOPE)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SCOPE = [VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES]
        super.viewDidLoad()
        VKSdk.initialize(withAppId: "5861075").register(self)
        VKSdk.instance().uiDelegate = self
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if(state == .authorized) {
                self.startWorking()
            }
            else if (error != nil) {
                displayAlert(delegate: self, title: "", message: "error", buttonTitle: "Ok")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func startWorking() {
        self.performSegue(withIdentifier: "startWork", sender: self)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.navigationController?.topViewController)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult) {
        if (result.token != nil) {
            self.startWorking()
        }
        else if (result.error != nil) {
            displayAlert(delegate: self, title: "", message: "Access denied\n\(result.error)", buttonTitle: "Ok")
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        displayAlert(delegate: self, title: "", message: "Access denied", buttonTitle: "Ok")
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController) {
        self.navigationController?.topViewController?.present(controller, animated: true, completion: { _ in })
    }
}

