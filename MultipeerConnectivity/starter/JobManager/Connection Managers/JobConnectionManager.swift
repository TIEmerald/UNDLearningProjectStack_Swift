/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import MultipeerConnectivity

class JobConnectionManager: NSObject, ObservableObject {
  typealias JobReceivedHandler = (JobModel) -> Void
  
  // MARK: - Accessors
  private let session: MCSession
  private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
  private let jobReceivedHandler: JobReceivedHandler?
  
  private static let service = "jobmanager-jobs"
  private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
  
  var isReceivingJobs: Bool = false {
    didSet {
      if isReceivingJobs {
        nearbyServiceAdvertiser.startAdvertisingPeer()
        print("Started advertising")
      } else {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
        print("Stopped advertising")
      }
    }
  }
  
  @Published var employees: [MCPeerID] = []
  private var nearbyServiceBrowser: MCNearbyServiceBrowser

  // MARK: - Initial
  init(_ jobReceivedHandler: JobReceivedHandler? = nil) {
    // 3
    session = MCSession(
      peer: myPeerId,
      securityIdentity: nil,
      encryptionPreference: .none)
    // 4
    self.jobReceivedHandler = jobReceivedHandler
    self.nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
      peer: myPeerId,
      discoveryInfo: nil,
      serviceType: JobConnectionManager.service)
    self.nearbyServiceBrowser = MCNearbyServiceBrowser(
      peer: myPeerId,
      serviceType: JobConnectionManager.service)

    super.init()
    self.nearbyServiceAdvertiser.delegate = self
    self.nearbyServiceBrowser.delegate = self

  }
  
  // MARK: - General Method
  func startBrowsing() {
    nearbyServiceBrowser.startBrowsingForPeers()
  }

  func stopBrowsing() {
    nearbyServiceBrowser.stopBrowsingForPeers()
  }
}


extension JobConnectionManager: MCNearbyServiceAdvertiserDelegate {
  func advertiser(
    _ advertiser: MCNearbyServiceAdvertiser,
    didReceiveInvitationFromPeer peerID: MCPeerID,
    withContext context: Data?,
    invitationHandler: @escaping (Bool, MCSession?) -> Void
  ) {
    guard
      let window = UIApplication.shared.windows.first,
      // 1
      let context = context,
      let jobName = String(data: context, encoding: .utf8)
    else {
      return
    }
    let title = "Accept \(peerID.displayName)'s Job"
    let message = "Would you like to accept: \(jobName)"
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    alertController.addAction(UIAlertAction(
      title: "No",
      style: .cancel
    ) { _ in
      // 2
      invitationHandler(false, nil)
    })
    alertController.addAction(UIAlertAction(
      title: "Yes",
      style: .default
    ) { _ in
      // 3
      invitationHandler(true, self.session)
    })
    window.rootViewController?.present(alertController, animated: true)
  }
}

extension JobConnectionManager: MCNearbyServiceBrowserDelegate {
  func browser(
    _ browser: MCNearbyServiceBrowser,
    foundPeer peerID: MCPeerID,
    withDiscoveryInfo info: [String: String]?
  ) {
    // 1
    if !employees.contains(peerID) {
      employees.append(peerID)
    }
  }

  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    guard let index = employees.firstIndex(of: peerID) else { return }
    // 2
    employees.remove(at: index)
  }
}
