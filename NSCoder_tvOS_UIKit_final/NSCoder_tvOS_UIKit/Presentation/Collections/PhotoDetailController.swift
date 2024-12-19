//
//  PhotoDetailController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit
import Kingfisher
import UnsplashApi
import NSCoder_tvOS_Domain

class PhotoDetailController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbTwitterAcoount: UILabel!
    private var photo: NSCPhoto
    
    init(photo: NSCPhoto) {
        self.photo = photo
        super.init(nibName: String(describing: PhotoDetailController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.kf.setImage(with: URL(string: photo.urlImage ?? ""), options: [.transition(.fade(0.3)), .forceTransition])
        if let username = photo.userName {
            lbUsername.text = username
        } else {
            lbUsername.isHidden = true
        }
            
        if let twitterAccount = photo.userTwitter {
            lbTwitterAcoount.text = "@\(twitterAccount)"
        } else {
            lbTwitterAcoount.isHidden = true
            lbTwitterAcoount.text = nil
        }
    }
}
