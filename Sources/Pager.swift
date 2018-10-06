//
//  Pager.swift
//  Funambol
//
//  Created by Matteo Battistini on 14/02/2018.
//  Copyright © 2018 Funambol. All rights reserved.
//

import UIKit

public typealias PagerPage = (UIViewController, String)
public typealias PagerCallback = (Int) -> Void

public class Pager: UIViewController  {
    
    private var viewControllers: [PagerPage]?
    private var pagerVC: PagerViewController?
    private lazy var stackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = UILayoutConstraintAxis.horizontal
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 0.0
        stackView.backgroundColor = UIColor.red
        return stackView
    }()
    private lazy var selectorsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var pagerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true;
        scrollView.isExclusiveTouch = true;
        scrollView.canCancelContentTouches = true;
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    private var wButtons : [WeakRef<UIButton>]?
    var appearence: PagerAppearance? {
        didSet {
            // reload layout
        }
    }
    public var willAppear: PagerCallback? = nil
    public var didAppear: PagerCallback? = nil
    
    
    public init(_ viewControllers: [PagerPage]?, appearence: PagerAppearance? = nil) {
        self.viewControllers = viewControllers
        self.appearence = appearence
        let pages = self.viewControllers?.map({ $0.0 })
        self.pagerVC = PagerViewController(pages: pages ?? [],
                                           transitionStyle: UIPageViewControllerTransitionStyle.scroll,
                                           navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal,
                                           options: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        self.setupSubviews()
        self.setupObserver()
        self.show(index: self.appearence?.selected ?? 0)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    public func show(index: Int) {
        self.pagerVC?.show(index: index)
    }
    
    @objc func selectorTapped(_ button: UIButton) {
        self.setSelected(button)
        pagerVC?.show(index: button.tag)
    }
    
    private func setSelected(_ button: UIButton) {
        wButtons?.forEach({ $0.value?.isSelected = false })
        button.isSelected = true
    }
    
    private func setupSubviews() {
        
        // add selectors container
        view.addSubview(selectorsContainer)
        // setup selectors container
        NSLayoutConstraint.activate([
            selectorsContainer.topAnchor.constraint(equalTo: view.topAnchor),
            selectorsContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            selectorsContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            selectorsContainer.heightAnchor.constraint(equalToConstant: self.appearence?.height ?? 0.0)
        ])
        
        // add scrollview
        selectorsContainer.addSubview(scrollView)
        // setup scrollview constraint
        scrollView.match(selectorsContainer)
        
        // add stack view
        scrollView.addSubview(stackView)
        
        // setup stackview contraints
        stackView.match(scrollView)
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        // create buttons
        let buttons = viewControllers?.enumerated().map { button($1.1, tag: $0) }
        
        // add buttons
        buttons?.forEach(stackView.addArrangedSubview)
        
        // layout buttons
        buttons?.forEach(applyContraints)
        
        wButtons = buttons?.map({ WeakRef($0) })
        
        // add pager container
        view.addSubview(pagerContainer)
        
        // setup pager container contraints
        NSLayoutConstraint.activate([
            pagerContainer.topAnchor.constraint(equalTo: selectorsContainer.bottomAnchor),
            pagerContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagerContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        pagerVC?.view.translatesAutoresizingMaskIntoConstraints = false
        self.add(childController: pagerVC, toView: pagerContainer)
    }
    
    private func setupObserver() {

        self.pagerVC?.currentIndex.addObserver(self, handler: { (self) in
            self.showButton(self.pagerVC?.currentIndex.value)
            if let index = self.pagerVC?.currentIndex.value {
                self.didAppear?(index)
            }
        })
        
    }
    
    private func button(_ title: String, tag: Int? = 0) -> UIButton {
        let button = UIButton()
        button.tag = tag ?? 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: UIControlState.normal)
        button.backgroundColor = self.appearence?.color
        self.appearence?.titleColors?.forEach({ (color, state) in
            button.setTitleColor(color, for: state)
        })
        button.titleLabel?.font = self.appearence?.font
        button.addTarget(self, action: #selector(Pager.selectorTapped(_:)), for: UIControlEvents.touchUpInside)
        return button
    }
    
    
    private func applyContraints(_ button: UIButton) {
        guard let type = self.appearence?.type else { return }
        switch type {
        case .dynamic:
            button.sizeToFit()
            button.heightAnchor.constraint(equalTo: self.stackView.heightAnchor).isActive = true
            button.widthAnchor.constraint(equalToConstant: button.frame.width + 16 ).isActive = true
        case .fixedWidth(let width):
            button.heightAnchor.constraint(equalTo: self.stackView.heightAnchor).isActive = true
            button.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .fixedNumber(let number):
            button.heightAnchor.constraint(equalTo: self.stackView.heightAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: self.selectorsContainer.widthAnchor, multiplier: 1.0.cgFloat / number.cgFloat ).isActive = true
        }
    }
    
    private func showButton(_ index: Int?) {
        guard let index = index else {
            return
        }
        if let wButton = wButtons?[index], let button = wButton.value {
            self.setSelected(button)
            scrollView.scrollRectToVisible(button.frame, animated: true)
        }
    }
}
