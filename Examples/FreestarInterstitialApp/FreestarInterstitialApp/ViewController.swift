//
//  ViewController.swift
//  FreestarInterstitialApp
//
//  Created by Dean Chang on 4/21/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

import UIKit
import FSAdSDK
import GoogleMobileAds

class ViewController: UIViewController, FSRegistrationDelegate {
    
    // DFP Ad Unit ID
    let adUnitID = "/15184186/freestar_test_Interstitial"
    // Freestar Ad Identifier
    let adIdentifier = "freestar_test_Interstitial"
    // interstitial
    var interstitial: FSInterstitial?
    
    @IBOutlet weak var loadingLabel: UILabel?
    
    deinit {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = NotificationCenter.default
        // notification to check registration status, optional
        notification.addObserver(self, selector: #selector(self.receivedRegistrationStatus(_:)), name: .FSRegistrationStatus, object: nil)
    }
    
    func loadInterstitial() {
        interstitial = FSAdProvider.createInterstitial(withIdentifier: adIdentifier, adUnitId: adUnitID, registrationDelegate: nil, eventHandler: nil)
        let request: DFPRequest? = DFPRequest()
        interstitial?.load(request)
    }
    
    func presentInterstitial() {
        if (interstitial!.isReady) {
            interstitial?.present(fromRootViewController: self)
            loadingLabel?.text = "Done."
        } else {
            loadingLabel?.text = "Retrying..."
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                // present interstitial
                self.presentInterstitial()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Freestar registration notification callback
    @objc func receivedRegistrationStatus(_ notification: NSNotification) {
        let status: NSNumber? = notification.userInfo!["status"] as? NSNumber
        // registration completed
        //     initial  = 0,
        //     error    = 1,
        //     success  = 2
        print("status: \(status!)")
        if FSRegistrationStatus.success.rawValue == status?.uintValue {
            // load banner after registration is completed, optional
            loadInterstitial()
            
            // 5 second delay to allow interstitial to become ready
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                // present interstitial
                self.presentInterstitial()
            }
        }
    }
    
    // MARK: FSRegistrationDelegate
    func didRegister(forIdentifier identifier: String) {
        print("registration success.")
    }
    
    func didFailToRegister(forIdentifier identifier: String) {
        print("registration failure.")
    }
}

