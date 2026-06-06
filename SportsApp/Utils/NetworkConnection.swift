//
//  NetworkConnection.swift
//  SportsApp
//
//  Created by albaraa alsayed on 19/12/1447 AH.
//


import Foundation
import Network
import UIKit

final class NetworkConnection {
    
    static let shared = NetworkConnection()
    private init() {}
    
    func isOnline(on viewController: UIViewController, action: @escaping () -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    action()
                } else {
                    AlertManager.showNoInternetAlert(on: viewController, title: "No Internet Connection", message: "Please check your Wi-Fi or Cellular network and try again.")
                }
                monitor.cancel()
            }
        }
        
        monitor.start(queue: queue)
    }
    
}
