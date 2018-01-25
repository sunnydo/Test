//
//  SimplePingClient.swift
//  SpeedTest
//
//  Created by Sunny on 1/22/18.
//  Copyright © 2018 Sunny Do. All rights reserved.
//

import Foundation

typealias SimplePingClientCallback = (String?)->()

class SimplePingClient:NSObject {
    var resultCallback: SimplePingClientCallback?
    var pingClinet: SimplePing?
    var dateReference: NSDate?
    var sendTimer: Timer?
    func pingHostname(hostname: String, andResultCallback callback: SimplePingClientCallback?) {
        resultCallback = callback
        let formatedHostname = hostFormater(domain: hostname)
        pingClinet = SimplePing(hostName: formatedHostname!)
        pingClinet?.delegate = self
        pingClinet?.start()
    }
    
    func hostFormater (domain:String) -> String! {
        var formatedDomain = domain.replacingOccurrences(of: "http://", with: "")
        formatedDomain = formatedDomain.replacingOccurrences(of: "https://", with: "")
        while formatedDomain.last == "/" {
            formatedDomain = String(formatedDomain.dropLast())
        }
        return formatedDomain
    }

}

extension SimplePingClient: SimplePingDelegate {
    func stop() {
        NSLog("stop")
        pingClinet?.stop()
        pingClinet = nil
        
        self.sendTimer?.invalidate()
        self.sendTimer = nil
    }
    
    /// Sends a ping.
    ///
    /// Called to send a ping, both directly (as soon as the SimplePing object starts up) and
    /// via a timer (to continue sending pings periodically).
    
    @objc func sendPing() {
        pingClinet!.send(with: nil)
    }
    
    // MARK: pinger delegate callback
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        NSLog("pinging %@")
        
        // Send the first ping straight away.
        
        self.sendPing()
        
        // And start a timer to send the subsequent pings.
        
    }
    func simplePing(_ pinger: SimplePing, didSendPacket packet: Data, sequenceNumber: UInt16) {
        dateReference = NSDate()
    }
    
    func simplePing(_ pinger: SimplePing, didFailWithError error: Error) {
        NSLog("\(error.localizedDescription)")
    }
    
    
    func simplePing(_ pinger: SimplePing, didReceivePingResponsePacket packet: Data, sequenceNumber: UInt16) {
        pinger.stop()
        
        guard let dateReference = dateReference else { return }
        
        //timeIntervalSinceDate returns seconds, so we convert to milis
        let latency = NSDate().timeIntervalSince(dateReference as Date) * 1000
        
        resultCallback?(String(format: "%.f", latency))
    }
    
    
}
