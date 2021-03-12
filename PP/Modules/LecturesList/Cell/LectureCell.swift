import UIKit

class LectureCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    }()
    
    let moreButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        
        return button
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "bottom-arrow")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor(hex: 0xEBEBF5).withAlphaComponent(0.3)
        
        return view
    }()
    
    let widthView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(widthView)
        contentView.addSubview(moreButton)
        contentView.addSubview(arrowImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotateArrow() {
        UIView.animate(withDuration: 0.3) {
            self.arrowImageView.tintColor = self.arrowImageView.transform == .identity ? .white : UIColor(hex: 0xEBEBF5).withAlphaComponent(0.3)
            self.arrowImageView.transform = self.arrowImageView.transform == .identity ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
        }
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(8)
            make.right.equalTo(moreButton.snp.left).offset(12)
            make.bottom.equalToSuperview().offset(-8)
        }
        widthView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        moreButton.snp.makeConstraints { make in
            make.right.equalTo(arrowImageView.snp.left).offset(-13)
            make.height.width.equalTo(33)
            make.centerY.equalToSuperview()
        }
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(22)
            make.centerY.equalToSuperview()
        }
    }
}
