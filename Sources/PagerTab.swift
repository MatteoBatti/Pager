//
//  Pager.swift
//
//  Created by Matteo Battistini on 14/02/2018.
//

import UIKit

// controller, title, accessibiliuty
public typealias PagerTabPage = (UIViewController, String)
public typealias PagerTabCallback = (Int, PagerTabPage) -> Void

public class PagerTab: UIViewController  {
    
    private var viewControllers: [PagerTabPage]?
    private var pagerVC: PagerTabViewController?
    private lazy var stackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
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
    var appearence: PagerTabAppearance? {
        didSet {
            //TODO: reload layout
        }
    }
    
    weak public var delegate: PagerTabDelegate? = nil
    
    
    public init(_ viewControllers: [PagerTabPage]?, appearence: PagerTabAppearance? = nil) {
        self.viewControllers = viewControllers
        self.appearence = appearence
        let pages = self.viewControllers?.map({ $0.0 })
        self.pagerVC = PagerTabViewController(pages: pages ?? [],
                                           transitionStyle: UIPageViewController.TransitionStyle.scroll,
                                           navigationOrientation: UIPageViewController.NavigationOrientation.horizontal,
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
        let buttons   = viewControllers?.enumerated().map({ tuple -> UIButton in
            let (index, viewController) = tuple
            return ButtonFactory.button(viewController.1, tag: index, appearence: self.appearence, target: self, action: #selector(PagerTab.selectorTapped(_:)), accessibilityIdentifier: viewController.0.view.accessibilityIdentifier)
        })
        
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
            if let index = self.pagerVC?.currentIndex.value, let page = self.viewControllers?[index] {
                self.delegate?.pageDidAppear(index, page: page)
            }
        })
        
    }
    
    private func button(_ title: String, tag: Int? = 0) -> UIButton {
        let button = UIButton()
        button.tag = tag ?? 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: UIControl.State.normal)
        button.backgroundColor = self.appearence?.color
        self.appearence?.titleColors?.forEach({ (color, state) in
            button.setTitleColor(color, for: state)
        })
        button.titleLabel?.font = self.appearence?.font
        button.addTarget(self, action: #selector(PagerTab.selectorTapped(_:)), for: UIControl.Event.touchUpInside)
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
