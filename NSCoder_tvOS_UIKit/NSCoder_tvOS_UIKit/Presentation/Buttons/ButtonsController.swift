//
//  ButtonsController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import AVKit
import Kingfisher

class ButtonsController: UIViewController {
    
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var focusView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    private let imageUrl = "https://images.unsplash.com/photo-1662946834880-99adabd21f80?q=80&w=3328&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
        imgView.kf.setImage(with: URL(string: imageUrl), options: [.transition(.fade(3)), .forceTransition])
    }
    
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback)
        } catch {
            // Handle error.
        }
    }

    
    // Create two players to show PiP swap feature in tvOS
    @IBAction func button1Tapped(_ sender: Any) {
        let urlStr = "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8"
        guard let url = URL(string: urlStr) else { return }
        
        let playerItrm = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItrm)
        let playerController = AVPlayerViewController()
        playerController.delegate = self
        playerController.player = player
        
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    
    @IBAction func button2Tapped(_ sender: Any) {
        
        let urlStr = "https://ott.dolby.com/OnDelKits/DDP/Dolby_Digital_Plus_Online_Delivery_Kit_v1.4.1/Test_Signals/muxed_streams/HLS/Manifest_v7_fMP4/ChID_voices_1280x720p_2997fps_h264_multi_codec.m3u8"
        guard let url = URL(string: urlStr) else { return }
        
        let playerItrm = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItrm)
        let playerController = AVPlayerViewController()
        playerController.delegate = self
        playerController.player = player
        
        present(playerController, animated: true) {
            player.play()
        }
    }
}


// MARK: AVPlayerViewControllerDelegate
extension ButtonsController: @preconcurrency AVPlayerViewControllerDelegate {

    func playerViewControllerShouldDismiss(_ playerViewController: AVPlayerViewController) -> Bool {
        if let presentedViewController = presentedViewController as? AVPlayerViewController,
            presentedViewController == playerViewController {
            return true
        }
        return false
    }

    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        // Dismiss the controller when PiP starts so that the user is returned to the item selection screen.
        return true
    }

    func playerViewController(_ playerViewController: AVPlayerViewController,
                                    restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        restore(playerViewController: playerViewController, completionHandler: completionHandler)
    }
    
    func restore(playerViewController: UIViewController, completionHandler: @escaping (Bool) -> Void) {
        // Restore the player view controller when coming back from PiP (expanding to full screen).
        // If there's already a presented controller, dismiss it and then present the new one; otherwise present it immediately.
        if let presentedViewController = presentedViewController {
            presentedViewController.dismiss(animated: false) { [weak self] in
                self?.present(playerViewController, animated: false) {
                    completionHandler(true)
                }
            }
        } else {
            present(playerViewController, animated: false) {
                completionHandler(true)
            }
        }
    }
}
