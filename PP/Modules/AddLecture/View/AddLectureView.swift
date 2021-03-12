import UIKit

class AddLectureView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Имя"
        
        return label
    }()
    
    let dragIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        view.layer.cornerRadius = 2.5
        
        return view
    }()
    
    let nameTextField: UITextField = {
        let text = UITextField()
        text.font = .systemFont(ofSize: 27)
        text.placeholder = "Может Виталий?"
        
        return text
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        return view
    }()
    
    let saveButton: HighlightedButton = {
        let button = HighlightedButton()
        button.adjustsImageWhenHighlighted = false
        button.layer.cornerRadius = 9
        button.clipsToBounds = true
        button.backgroundColor = .blue
        button.setTitle("Сохранить", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: 0x5a6169)
        
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(separatorView)
        addSubview(dragIndicator)
        addSubview(saveButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        dragIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(40)
            make.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(33)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        separatorView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(nameTextField.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(1)
        }
        
        saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(nameTextField.snp.bottom).offset(17)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
    }
    
}
