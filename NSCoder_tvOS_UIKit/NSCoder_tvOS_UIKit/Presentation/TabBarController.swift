//
//  TabBarController.swift
//  NSCoder_tvOS_UIKit
//
//  Created by Pedro on 2/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var buttonsVC = {
        let buttonsVC = ButtonsController()
        let navigationVC = UINavigationController(rootViewController: buttonsVC)
        navigationVC.title = "Buttons"
        navigationVC.isNavigationBarHidden = true
        return navigationVC
    }()
    
    lazy var textFieldsVC = {
        let textFieldsVC = TextFiledsController()
        let navigationVC = UINavigationController(rootViewController: textFieldsVC)
        navigationVC.title = "TextFields"
        navigationVC.isNavigationBarHidden = true
        return navigationVC
    }()
    
    lazy var collectionsVC = {
        let collectionsVC = CollectionsController()
        let navigationVC = UINavigationController(rootViewController: collectionsVC)
        navigationVC.title = "Collections"
        navigationVC.isNavigationBarHidden = true
        return navigationVC    }()
    
    override func viewDidLoad() {
        self.delegate = self
        self.viewControllers = [buttonsVC, textFieldsVC, collectionsVC]
    }
    
}



extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension TabBarController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return .zero
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let view = transitionContext.view(forKey: .to) else {
            return
        }
        
        let container = transitionContext.containerView
        container.addSubview(view)
        
        transitionContext.completeTransition(true)
    }
}


