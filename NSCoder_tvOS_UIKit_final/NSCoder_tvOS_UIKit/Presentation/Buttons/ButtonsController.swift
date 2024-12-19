//
//  ButtonsController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import AVKit
import Kingfisher
import TVUIKit

class ButtonsController: UIViewController {
    
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var focusView: FocusableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardView: TVCardView!
    
    override var preferredFocusEnvironments: [any UIFocusEnvironment] {
        [btnTwo]
    }
    var focusGuide: UIFocusGuide?

    private let imageUrl = "https://images.unsplash.com/photo-1662946834880-99adabd21f80?q=80&w=3328&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
        self.restoresFocusAfterTransition = false
        imgView.kf.setImage(with: URL(string: imageUrl), options: [.transition(.fade(3)), .forceTransition])
        imgView.adjustsImageWhenAncestorFocused = true
        imgView2.kf.setImage(with: URL(string: imageUrl), options: [.transition(.fade(3)), .forceTransition])
        configureFocusGuide()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(remotePlayButtonTapped))
        let gestures = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        tapGesture.allowedPressTypes = gestures
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback)
        } catch {
            // Handle error.
        }
    }
    
    
    // Add guide to allow change focus from cardView to btnTwo
    func configureFocusGuide() {
        focusGuide = UIFocusGuide()
        guard let focusGuide else { return }
        view.addLayoutGuide(focusGuide)
        NSLayoutConstraint.activate([
            focusGuide.bottomAnchor.constraint(equalTo: focusView.bottomAnchor),
            focusGuide.widthAnchor.constraint(equalTo: btnTwo.widthAnchor),
            focusGuide.leftAnchor.constraint(equalTo: btnTwo.leftAnchor),
            focusGuide.heightAnchor.constraint(equalTo: btnTwo.heightAnchor)
        ])
        
        focusGuide.preferredFocusEnvironments = [btnTwo]
        
        
        // View to debug focus guide
//        let viewGuide = UIView(frame: focusGuide.layoutFrame)
//        viewGuide.backgroundColor = .green.withAlphaComponent(0.3)
//        view.addSubview(viewGuide)
        
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
    
    @objc func remotePlayButtonTapped(sender: Any) {
        debugPrint("Play paused")
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        //Update constraints for lable depending of view is or not focused
        if context.nextFocusedView == focusView {
            topLabelConstraint.constant += (imgView.focusedFrameGuide.layoutFrame.size.height - imgView.frame.size.height) / 2
        } else {
            topLabelConstraint.constant = 15
        }
        
        // Update preferredFocusEnvironments depending of focused view
        if context.nextFocusedView == btnTwo {
            focusGuide?.preferredFocusEnvironments = [cardView]
        } else {
            focusGuide?.preferredFocusEnvironments = [btnTwo]
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


class FocusableView: UIView {
    override var canBecomeFocused: Bool {
        return true
    }
}
