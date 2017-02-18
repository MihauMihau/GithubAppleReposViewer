//
//  APIBase.swift
//  GitHubReposViewer
//
//  Created by Michał Michał on 17.02.2017.
//  Copyright © 2017 Organization. All rights reserved.
//

import UIKit
import SystemConfiguration

class APIBase: NSObject {

    func isStatusValid(_ c: Int?, url: String) -> Bool {
        if let code = c {
            if !(code >= 200 && code < 300) {
                print("ERROR CODE \(code) in \(url)")
            }
            return code >= 200 && code < 300
        }
        return false
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
