import UIKit

class ContainerViewController: UIViewController {
//    var viewControllers = [0: LecturesListViewController(), 1: MuteListViewController(), 2: BlockListViewController()]
    var viewControllers = [0: LecturesListViewController(), 1: AudienceListViewController()]

    var mainView: ContainerView {
        return view as! ContainerView
    }

    override func loadView() {
        let view = ContainerView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewControllers.values.forEach { $0.loadViewIfNeeded() }
        
        setupPageController()
        setupHeaderView()
    }
    
    @objc private func headerButtonTapped(_ sender: UIButton) {
        switch sender {
        case mainView.headerView.lecturerButton:
            mainView.pageViewController.setViewControllers([viewControllers[0]!], direction: .forward, animated: true, completion: nil)
            
        case mainView.headerView.audienceButton:
            mainView.pageViewController.setViewControllers([viewControllers[1]!], direction: .forward, animated: true, completion: nil)
            
        case mainView.headerView.groupButton:
            mainView.pageViewController.setViewControllers([viewControllers[2]!], direction: .forward, animated: true, completion: nil)
                        
        default:
            break
        }
    }
    
    private func changeSelectedButton(view controller: UIViewController?) {
        if let vc = controller {
            switch vc {
            case is LecturesListViewController:
                mainView.headerView.selectButton(mainView.headerView.lecturerButton)
                
            case is AudienceListViewController:
                mainView.headerView.selectButton(mainView.headerView.audienceButton)
//                
//            case is BlockListViewController:
//                mainView.headerView.selectButton(mainView.headerView.groupButton)
                
                
            default:
                break
            }
        }
    }
    
    private func setupPageController() {
        mainView.pageViewController.setViewControllers([viewControllers[0]!], direction: .forward, animated: false, completion: nil)
        addChild(mainView.pageViewController)
        
        mainView.pageViewController.didMove(toParent: self)
        mainView.pageViewController.dataSource = self
        mainView.pageViewController.delegate = self
    }
    
    private func setupHeaderView() {
        mainView.headerView.lecturerButton.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
        mainView.headerView.audienceButton.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
        mainView.headerView.groupButton.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
    }
}

// MARK: - UIPageViewControllerDelegate

extension ContainerViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ContainerPageable else { return nil }
        
        return viewControllers[viewController.index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? ContainerPageable else { return nil }
        
        return viewControllers[viewController.index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        changeSelectedButton(view: pendingViewControllers.first)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            changeSelectedButton(view: previousViewControllers.first)
        }
    }
    
}
