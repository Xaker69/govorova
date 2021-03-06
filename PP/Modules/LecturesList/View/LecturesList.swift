import UIKit

class LecturesListView: UIView {
        
    let addButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("Добавить препода", for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(LectureCell.self, forCellWithReuseIdentifier: LectureCell.description())
        view.register(SheduleCell.self, forCellWithReuseIdentifier: SheduleCell.description())
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(collectionView)
        addSubview(addButton)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(addButton.snp.bottom).offset(20)
        }
    }
}
