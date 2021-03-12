import UIKit

class SheduleCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    let roomNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(dayOfWeekLabel)
        containerView.addSubview(roomNumber)
    }
        
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 24)
            make.left.top.equalToSuperview().offset(12)
            make.bottom.right.equalToSuperview().offset(-12)
        }
        roomNumber.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(dayOfWeekLabel.snp.right).offset(12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.right.equalTo(roomNumber.snp.left)
        }
        
        roomNumber.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dayOfWeekLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
}
