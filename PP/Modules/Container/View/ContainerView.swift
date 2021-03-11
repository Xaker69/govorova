import UIKit

class ContainerView: UIView {

    let backgroundGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0.0, 1.0]
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.colors = [UIColor(hex:0x2E2E2E).cgColor, UIColor(hex:0x010101).cgColor]
        
        return layer
    }()
    
    let headerView: ListHeaderView = {
        let view = ListHeaderView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    let pageViewController: UIPageViewController = {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(backgroundGradientLayer)

        
        addSubview(pageViewController.view)
        addSubview(headerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundGradientLayer.frame = bounds
        
        headerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: safeAreaInsets.top + 40)
        pageViewController.view.frame = CGRect(x: 0, y: safeAreaInsets.top + 40, width: bounds.width, height: bounds.height - safeAreaInsets.top - 40)
    }
}
