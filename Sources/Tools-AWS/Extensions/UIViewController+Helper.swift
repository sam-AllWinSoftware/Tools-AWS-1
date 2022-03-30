import Foundation
import UIKit
import IHProgressHUD

extension UIViewController {

    func remove(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.removeFromParent()
        viewController.view.removeFromSuperview()
    }
    
    func remove(from view: UIView) {
        view.subviews.forEach { $0.removeFromSuperview() }
    }

    func add(viewController: UIViewController, to containingView: UIView) {
        if viewController.parent != nil {
            viewController.willMove(toParent: nil)
            viewController.removeFromParent()
        }
        containingView.addSubview(viewController.view)

        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: .directionLeadingToTrailing,
                                                                   metrics: nil,
                                                                   views: ["view": viewController.view as Any]))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                   options: .directionLeadingToTrailing,
                                                                   metrics: nil,
                                                                   views: ["view": viewController.view as Any]))
        viewController.didMove(toParent: self)
    }

    func cycle(from oldViewController: UIViewController, to newViewController: UIViewController, in containingView: UIView) {
        add(viewController: newViewController, to: containingView)
        UIView.transition(from: oldViewController.view, to: newViewController.view, duration: 0.2, options: [.transitionCrossDissolve, .showHideTransitionViews]) { _ in
            oldViewController.willMove(toParent: nil)
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
        }
    }
}

extension UIViewController {

    func showLoadingIndicator() {
        IHProgressHUD.show()
    }

    func dismissLoadingIndicator() {
        IHProgressHUD.dismiss()
    }
}

extension UIViewController {
    
    func allowedOrientationsFor(iPhone: UIInterfaceOrientationMask, iPad: UIInterfaceOrientationMask) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            switch traitCollection.userInterfaceIdiom {
            case .phone:
                appDelegate.restrictRotation = iPhone
                setUpOrientation(iPhone)
            case .pad:
                appDelegate.restrictRotation = iPad
                setUpOrientation(iPad)
            default:
                appDelegate.restrictRotation = .all
            }
        }
    }
    
    private func setUpOrientation(_ orientation: UIInterfaceOrientationMask) {
        switch orientation {
        case .portrait:
            setDeviceOrientation(UIInterfaceOrientation.portrait)
        case .landscape:
            setDeviceOrientation(UIInterfaceOrientation.landscapeLeft)
        case .landscapeRight:
            setDeviceOrientation(UIInterfaceOrientation.landscapeRight)
        case .landscapeLeft:
            setDeviceOrientation(UIInterfaceOrientation.landscapeLeft)
        default:
            setDeviceOrientation(UIInterfaceOrientation.portrait)
        }
    }
    
    private func setDeviceOrientation(_ orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}
