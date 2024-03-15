//
//  BaseViewController.swift
//
//
//  Created by . 
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView?
    var tap = UITapGestureRecognizer()
    
    let dayImages = ["sundayD", "mondayD", "tuesdayD", "wednesdayD", "thursdayD", "fridayD", "saturdayD"]
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.delegate = self
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.tintColor = MyColors.black.color
        self.navigationController?.navigationBar.topItem?.title = ""
        setTransculantNavBar(showsBottomLine: true)
        hideNavBar()
    }
    
    func setCustomNavBar() {   
        let backButtonImage = UIImage(named: "backArrow")
        
        // Create a UIBarButtonItem with the custom image
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        
        // Assign the custom back button as the left bar button item
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        popViewController()
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissAllPresentedViewControllers() {
          var presentedViewController = presentingViewController
          while let presentedVC = presentedViewController?.presentingViewController {
              presentedViewController = presentedVC
          }
          presentedViewController?.dismiss(animated: true)
      }

    
    func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = MyColors.background.color
        appearance.titleTextAttributes = [.foregroundColor: MyColors.black.color]
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = MyColors.black.color
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setTransculantNavBar(showsBottomLine: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: MyColors.black.color]
        navigationController?.navigationBar.tintColor = MyColors.white.color
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Light", size: 13)]
        UINavigationBar.appearance().titleTextAttributes = attributes
     

        UINavigationBar.appearance().standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationItem.compactAppearance = appearance
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open func hideKeyboardWhenTappedAround() {
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func refresh(sender:UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
            
            sender.endRefreshing()
        }
    }
    
    @objc open func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getSavedDayOfWeekIndices() -> [Int] {
        if let dayOfWeekIndices = UserDefaults.standard.array(forKey: "dayOfWeekIndices") as? [Int] {
            return dayOfWeekIndices
        } else {
            return []
        }
    }

    
//    func setRules() {
//        let logoImage = UIBarButtonItem(image:UIImage(named: "rules"), style: .plain, target: self, action: #selector(goToRules))
//        navigationItem.rightBarButtonItem = logoImage
//    }
    
//    @objc func goToRules() {
//        let rulesVC = game.instantiateViewController(withIdentifier: "RulesVC") as! RulesVC
//        self.presentPanModal(rulesVC)
//    }
    
//    func round2() {
//        let gameVC2 = game.instantiateViewController(withIdentifier: "GameVC2")
//        self.navigationController?.pushViewController(gameVC2, animated: true)
//    }
//
//    func round3() {
//        let gameVC2 = game.instantiateViewController(withIdentifier: "GameVC3")
//        self.navigationController?.pushViewController(gameVC2, animated: true)
//    }
//
//    func round4() {
//        let gameVC2 = game.instantiateViewController(withIdentifier: "GameVC4")
//        self.navigationController?.pushViewController(gameVC2, animated: true)
//    }
//
//    func round5() {
//        let gameVC2 = game.instantiateViewController(withIdentifier: "GameVC5")
//        self.navigationController?.pushViewController(gameVC2, animated: true)
//    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToTopViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
    
    func hideNavBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showNavBar() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setNavigationTint() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setNavigationBackButton() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setCategoryNav() {
        let logoImage = UIBarButtonItem(image:UIImage(named: "rules"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = logoImage
    }
    
    func setcategoryNav2() {
        navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
        let coins = UIBarButtonItem(image:  UIImage(named: "coins"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = coins
        navigationItem.rightBarButtonItem?.tintColor = MyColors.orange.color
    }
    
//    func setBarButtons() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"logo"), style: .plain, target: self, action: nil)
//        navigationItem.leftBarButtonItem?.tintColor = MyColors.orange.color
//        navigationItem.titleView = BaseTextField()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"coins"), style: .plain, target: self, action: nil)
//        navigationItem.rightBarButtonItem?.tintColor = MyColors.orange.color
//    }
    
//    func showActivity() {
//        activityIndicator = ActivityManager.shared.showActivityIndicator(in: view)
//    }
    
    func hideActivity() {
        activityIndicator?.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension BaseViewController {
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in}
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showAlertLocation(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Перейти", style: .default) { _ in
            if let url = URL(string: "App-prefs:root=Privacy&path=LOCATION") {
                UIApplication.shared.open(url,options: [:],completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - Custom alert
extension BaseViewController {
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func setAlert(alertView: UIView) {
        view.addSubview(alertView)
        alertView.center = view.center
    }
    
    func animateIn(alertView: UIView) {
        view.addSubview(alertView)
        alertView.alpha = 0

        // Position the alertView
        alertView.center = CGPoint(x: view.center.x, y: view.bounds.height + 200)

        // Apply initial transformation
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)

        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            alertView.alpha = 1

            // Center the alertView horizontally and move it up
            alertView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            
            // Apply the identity transformation
            alertView.transform = CGAffineTransform.identity
        }
    }

    
    func animateOut(alertView: UIView) {
        UIView.animate(withDuration: 0.4,
                       animations: {
            self.visualEffectView.alpha = 0
            alertView.alpha = 0
            alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            alertView.removeFromSuperview()
        }
    }
}


extension BaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Don't handle button taps
        return !(touch.view is UIButton)
    }
}
