//
//  HoroscopeContainerVC.swift
//  HoroscopeModule
//
//  Created by Varun Dudeja on 16/09/18.
//  Copyright © 2018 Varun Dudeja. All rights reserved.
//

import UIKit

protocol HoroscopeContainerPresenterLogic: class {
    func getSelectedZodiac(for UserId: String)
}

class HoroscopeContainerVC: BaseVC {
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var horoscopeBtn: UIButton!
    @IBOutlet var barLeadingSPace: NSLayoutConstraint!
    private var pageViewController: UIPageViewController!
    private var isHoroscopeSelected = true
    private var response: HoroscopeResponse?
    private var presenter: HoroscopeContainerPresenterLogic?
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    var currentTag = 0 {
        didSet {
            if currentTag == 0 {
                
                self.barLeadingSPace.isActive = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                self.barLeadingSPace.isActive = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    var pageInTransitionIndex = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        let presenter = HoroscopeContainerPresenter()
        presenter.displayLogic = self
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    private func initializeView() {
        horoscopeBtn.isEnabled = false
        settingsBtn.isEnabled = false
        presenter?.getSelectedZodiac(for: Constants.Test.uid)
    }
    
    private func setPageView(isHoroscopeSelected: Bool) {
        
        currentTag = 0
        
        self.isHoroscopeSelected = isHoroscopeSelected
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.setViewControllers([getInitialController()], direction: .forward, animated: false, completion: nil)
        pageViewController.view.frame = containerView.bounds
        addChildViewController(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        
        horoscopeBtn.isEnabled = true
        settingsBtn.isEnabled = true
    }
    
    private func getInitialController() -> UIViewController {
        
        var initialVC: UIViewController!
        if isHoroscopeSelected {
            initialVC = getHoroscopeController()
        } else {
            let vc = getSelectController()
            vc.isHoroscopeTab = true
            initialVC = vc
        }
        return initialVC
    }
    
    private func getSelectController() -> SelectHoroscopeVC {
        let vc = SelectHoroscopeVC()
        vc.delegate = self
        vc.response = response
        return vc
    }
    
    private func getHoroscopeController() -> HoroscopeVC {
        let vc = HoroscopeVC()
        vc.response = response
        return vc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func clickedTabBtn(_ sender: UIButton) {
        
        guard sender.tag != currentTag else {
            return
        }
        currentTag = sender.tag
        
        if sender.tag == 0 {
            
            pageViewController.setViewControllers([getInitialController()], direction: .reverse, animated: true,  completion: nil)
            
        } else {
            pageViewController.setViewControllers([getSelectController()], direction: .forward, animated: true,  completion: nil)
        }
    }
}

extension HoroscopeContainerVC: HoroscopeContainerDisplayLogic {
    func displayHoroscope(response: HoroscopeResponse, isZodiacAvailable: Bool) {
        self.response = response
        setPageView(isHoroscopeSelected: isZodiacAvailable)
    }
}

//MARK: - PageViewController Datasource

extension HoroscopeContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? SelectHoroscopeVC {
            if vc.isHoroscopeTab {
                return getSelectController()
            } else {
                return nil
            }
        } else if viewController is HoroscopeVC {
            return getSelectController()
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let vc = viewController as? SelectHoroscopeVC {
            if vc.isHoroscopeTab {
                return nil
            } else {
                return getInitialController()
            }
        } else if viewController is HoroscopeVC {
            return nil
        }
        return nil
    }
    
}

//MARK: - PageViewController Delegate

extension HoroscopeContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if (!completed) {
            let viewController = previousViewControllers.first
            if let vc = viewController as? SelectHoroscopeVC {
                if vc.isHoroscopeTab {
                    currentTag = 0
                } else {
                    currentTag = 1
                }
            } else if viewController is HoroscopeVC {
                currentTag = 0
            }

        } else {
            currentTag = pageInTransitionIndex
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        let viewController = pendingViewControllers.first
        if let vc = viewController as? SelectHoroscopeVC {
            if vc.isHoroscopeTab {
                pageInTransitionIndex = 0
            } else {
                pageInTransitionIndex = 1
            }
        } else if viewController is HoroscopeVC {
            pageInTransitionIndex = 0
        }
    }
}

//MARK: - SelectHoroscopeVC Delegate Conformance

extension HoroscopeContainerVC: SelectHoroscopeVCDelegate {
    func zodiacSelected(response: HoroscopeResponse?) {
        if response != nil {
            pageViewController.willMove(toParentViewController: nil)
            pageViewController.view.removeFromSuperview()
            pageViewController.removeFromParentViewController()
            displayHoroscope(response: response!, isZodiacAvailable: true)
        }
    }
}

