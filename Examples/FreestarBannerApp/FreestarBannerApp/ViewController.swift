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

class ViewController: UIViewController {
    // DFP Ad Unit ID
    let adUnitID = "/15184186/Freestar_Test_320x50"
    // Freestar Ad Identifier
    let adIdentifier = "Freestar_Test_320x50"
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
        // load banner
        loadBanner()
    }
    
    func loadBanner() {
        bannerView = FSAdProvider.createBanner(withIdentifier: adIdentifier,
                                               size: kGADAdSizeBanner,
                                               adUnitId: adUnitID,
                                               rootViewController: self,
                                               registrationDelegate: nil,
                                               eventHandler:nil)
        
        let request: DFPRequest? = DFPRequest()
        bannerView?.load(request)
        addToView(bannerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Freestar registration notification callback, optional
    @objc func receivedRegistrationStatus(_ notification: NSNotification) {
        let status: NSNumber? = notification.userInfo!["status"] as? NSNumber
        // registration completed
        //     initial = 0,
        //     error = 1,
        //     succes = 2        
        print("status: \(status!)")
//        if FSRegistrationStatus.success.hashValue == status?.intValue {
            // load banner after registration is completed, optional
//            loadBanner()
//        }
    }

    // UI layout
    func addToView(_ bannerView: UIView?) {
        bannerView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView!)
        
        var constraints: [NSLayoutConstraint]
        if #available(iOS 11.0, *) {
            constraints =
                [NSLayoutConstraint(item: bannerView!,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: view.safeAreaLayoutGuide,
                                          attribute: .top,
                                          multiplier: 1,
                                          constant: 0),
                       NSLayoutConstraint(item: bannerView!,
                                          attribute: .centerX,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .centerX,
                                          multiplier: 1,
                                          constant: 0)]
        } else {
           constraints =
                [NSLayoutConstraint(item: bannerView!,
                                    attribute: .top,
                                    relatedBy: .equal,
                                    toItem: topLayoutGuide,
                                    attribute: .top,
                                    multiplier: 1,
                                    constant: 0),
                 NSLayoutConstraint(item: bannerView!,
                                    attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view,
                                    attribute: .centerX,
                                    multiplier: 1,
                                    constant: 0)]
        }
        
        view.addConstraints(constraints)        
    }
}

