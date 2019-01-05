//
//  PagerViewController.swift
//  PagerTab
//
//  Created by Matteo Battistini on 15/02/2018.
//

import UIKit

class PagerTabViewController: UIPageViewController {
    
    var pages: [UIViewController] = []
    var currentIndex: Event<Int> = Event(0)
    
    var currentViewController: UIViewController? {
        get {
            return self.viewControllers?.first
        }
    }
    
    init(pages: [UIViewController], transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [String : Any]? = nil) {
        self.pages = pages
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: convertToOptionalUIPageViewControllerOptionsKeyDictionary(options))
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
    }
    
    internal func show(index: Int) {
        guard index < self.pages.count else { return }
        let vc = self.pages[index]
        let direction: UIPageViewController.NavigationDirection = (index > currentIndex.value) ? .forward : .reverse
        currentIndex.value = index
        setViewControllers([vc], direction: direction , animated: true, completion: nil)
    }
    
}


extension PagerTabViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = self.currentViewController {
            currentIndex.value = self.pages.index(of: currentViewController) ?? 0
        }
    }

    

}

extension PagerTabViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0, pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count, pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalUIPageViewControllerOptionsKeyDictionary(_ input: [String: Any]?) -> [UIPageViewController.OptionsKey: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIPageViewController.OptionsKey(rawValue: key), value)})
}
