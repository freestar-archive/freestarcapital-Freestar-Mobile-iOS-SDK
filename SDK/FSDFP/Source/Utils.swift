/*   Copyright 2018-2019 Prebid.org, Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import GoogleMobileAds
import PrebidMobileFS

public class Utils: NSObject {
    
    /**
     * The class is created as a singleton object & used
     */
    public static let shared = Utils()
    
    /**
     * The initializer that needs to be created only once
     */
    private override init() {
        super.init()
        
    }
    
    func keywordsFor(identifier: String) -> [AnyHashable: Any]? {
        let adUnit: PBAdUnit? = PBBidManager.sharedInstance().adUnit(byIdentifier: identifier)
        guard let validAdUnit = adUnit else {
            return nil
        }
        return PBBidManager.sharedInstance().keywordsForWinningBid(for: validAdUnit)
    }
    
    func mergeFSAppKVPair(_ keywords: [AnyHashable: Any]) -> [AnyHashable: Any] {
        var fsAppKV: [AnyHashable: Any] = ["fs_app":"true"]
        fsAppKV.merge(dict: keywords)
        return fsAppKV
    }
    
    @objc public func removeHBKeywords(request: DFPRequest?) {
        precondition(request != nil)
        guard let gadRequest = request else {
            return
        }
        
        guard var existingDict: [String: Any] = gadRequest.customTargeting as? [String : Any] else {
            return
        }
        
        //check if the publisher has added any custom targeting. If so then merge the bid keywords to the same.
        for (key, _)in existingDict {
            if (key.starts(with: "hb_")) {
                existingDict[key] = nil
            } else if (key == "fs_app") {
                existingDict[key] = nil
            }
        }
        gadRequest.customTargeting = existingDict
    }

    @objc func validateAndAttachKeywords(request: DFPRequest?, identifier: String?) {
        precondition(request != nil)
        precondition(identifier != nil)
        guard let gadRequest = request else {
            return
        }
        guard let identifier = identifier else {
            return
        }
        
        // ensure dfpRequest is not nil
        gadRequest.customTargeting = gadRequest.customTargeting ?? [AnyHashable: Any]()
        guard let existingDict = gadRequest.customTargeting else {
            return
        }
        var mergedDict = mergeFSAppKVPair(existingDict)
        gadRequest.customTargeting = mergedDict
        guard let keywords = keywordsFor(identifier: identifier) else {
            // no bid keywords so bail early
            return
        }
        guard let bidValue: String = keywords["hb_pb"] as? String else {
            // no hb_pb bid entry so bail early
            return
        }
        
        if bidValue != "0.00" {
            // merge the bid keywords
            mergedDict.merge(dict: keywords)
            gadRequest.customTargeting = mergedDict
        }
    }
}
