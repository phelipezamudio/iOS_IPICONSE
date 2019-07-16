//
//  OnBoardingPageViewController.swift
//  IPI
//
//  Created by Felipe Zamudio on 26/04/19.
//  Copyright © 2019 NRC. All rights reserved.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK: - Properties
    weak var onboardingDelegate: OnBoardingPageViewControllerDelegate?
    
    var pages : [Int] = OnboardingIndex.allCases.map { $0.rawValue }
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source and the delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnBoardingContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnBoardingContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - Helper
    func contentViewController(at index: Int) -> OnBoardingContentViewController? {
        
        if index < 0 || index >= pages.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data
        let storyboard = UIStoryboard(name: StoryboardID.OnBoarding.rawValue, bundle: nil)
        if let pageContentVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.OnBoardingContentVC.rawValue) as? OnBoardingContentViewController {
            
            let contentValues : [String:String] = getOnBoardingContent(forIndex: index)
            
            pageContentVC.imageName = contentValues[IPIKeys.image.rawValue] ?? nullString
            pageContentVC.onbortingTitle = contentValues[IPIKeys.title.rawValue] ?? nullString
            pageContentVC.onbortingText = contentValues[IPIKeys.description.rawValue] ?? nullString
            pageContentVC.index = index
            
            return pageContentVC
        }
        
        return nil
    }
    
    func forwardPage() {
        
        currentIndex += 1
        
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller delegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? OnBoardingContentViewController {
                currentIndex = contentViewController.index
                
                onboardingDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }

}
