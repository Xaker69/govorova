import UIKit

class ListHeaderView: UIView {
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.distribution = .fillProportionally
        return view
    }()
    
    let selectedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        
        return view
    }()
    
    let lecturerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Преподы", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    let audienceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Аудитории", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    let groupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Группы", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: safeAreaInsets.top + 40)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        addSubview(selectedView)
        
        stackView.insertArrangedSubview(lecturerButton, at: 0)
        stackView.insertArrangedSubview(audienceButton, at: 1)
        stackView.insertArrangedSubview(groupButton, at: 2)
        
        lecturerButton.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        audienceButton.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        groupButton.addTarget(self, action: #selector(selectButton(_:)), for: .touchUpInside)
        
        setupConstraints()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frame = lecturerButton.convert(lecturerButton.frame, to: .init(frame: UIScreen.main.bounds))
        self.selectedView.frame = CGRect(x: frame.maxX/2 - 2, y: frame.minY - 8, width: 4, height: 4)
    }
    
    @objc func selectButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.lecturerButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            self.lecturerButton.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .normal)
            
            self.audienceButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            self.audienceButton.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .normal)
            
            self.groupButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            self.groupButton.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .normal)
            
            
            sender.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
            sender.setTitleColor(.white, for: .normal)
        }
        
        UIView.animate(withDuration: 0.3) {
            let frame = sender.convert(sender.frame, to: .init(frame: UIScreen.main.bounds))
            self.selectedView.frame = CGRect(x: frame.maxX/2 - 2, y: frame.minY - 8, width: 4, height: 4)
        }
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

