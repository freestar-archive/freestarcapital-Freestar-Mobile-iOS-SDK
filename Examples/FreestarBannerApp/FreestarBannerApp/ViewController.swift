//
//  ViewController.swift
//  FreestarBannerApp
//
//  Created by Dean Chang on 4/21/18.
//  Copyright © 2018 Freestar. All rights reserved.
//

import UIKit
import FSAdSDK
import GoogleMobileAds

class ViewController: UIViewController, FSRegistrationDelegate {
    
    // DFP Ad Unit ID
    let adUnitID = "/15184186/Freestar_Test_300x250"
    // Freestar Ad Identifier
    let adIdentifier = "Freestar_Test_300x250"
    // banner
    var bannerView: (UIView & FSBanner)?
    
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
    
    func loadBanner() {
        bannerView = FSAdProvider.createBanner(withIdentifier: adIdentifier,
                                               size: kGADAdSizeMediumRectangle,
                                               adUnitId: adUnitID,
                                               registrationDelegate: self,
                                               eventHandler: { [weak self]
                                                    (methodName: String!, params: [ String : Any]) in
                                                    if (methodName == DFPEventNameBanner.adViewDidReceiveAd.rawValue) {
                                                        // implement your custom logic here
                                                    }
                                                })
        bannerView.rootViewController = self
        let request: DFPRequest? = DFPRequest()
        bannerView?.load(request)
        self.view.addSubview(self.bannerView!)
        self.anchorBanner(self.bannerView, size: (self.bannerView?.fsAdSize)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // anchor banner to center of superview
    func anchorBanner(_ banner: UIView?, size: CGSize) {
        banner?.translatesAutoresizingMaskIntoConstraints = false
        banner?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        banner?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        if (banner!.superview != nil) {
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            banner?.centerXAnchor.constraint(equalTo: banner!.superview!.centerXAnchor).isActive = true
            banner?.topAnchor.constraint(equalTo: banner!.superview!.topAnchor, constant: statusBarHeight).isActive = true
        }
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
            loadBanner()
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

