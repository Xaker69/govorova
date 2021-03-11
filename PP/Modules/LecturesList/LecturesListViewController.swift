import UIKit

class LecturesListViewController: UIViewController, ContainerPageable {

    var index: Int {
        return 2
    }
    
    private var isRefreshing = false
    private var searchQuery: String?
    private var blockList = [BlockStreamModel]()
        
    private var mainView: LecturesList {
        return view as! LecturesList
    }
    
    override func loadView() {
        let view = LecturesList()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        refreshControl.tintColor = UIColor.white.withAlphaComponent(0.8)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
              
        mainView.collectionView.refreshControl = refreshControl
        
        setupСollectionView()
//        blockListUpdate()
    }
    
    @objc private func refresh() {
        guard !isRefreshing else { return }
        isRefreshing = true
//        blockListUpdate()
    }
    
    @objc private func unbanButtonTapped(_ sender: UIButton) {
//        var model = blockList[index]
//        if searchQuery != nil {
//            model = getFilteredBlockList()[index]
//        }
//
//        BlasterAPI.request(StreamAPI.unban(userId: model.user.id)) { result in
//            do {
//                _ = try result.get()
//
//                DispatchQueue.main.async {
//                    ToastController.showNotification(title: "Хорошая работа, Олег", image: UIImage(named: "success"))
//                    self.blockList.remove(at: sender.tag)
//                    self.mainView.collectionView.performBatchUpdates {
//                        self.mainView.collectionView.deleteSections(IndexSet(arrayLiteral: sender.tag))
//                    }
//                    self.blockListUpdate()
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    ToastController.showNotification(title: error.localizedDescription)
//                }
//            }
//        }
    }
    
    private lazy var miniProfileAction: (Int) -> () = { [weak self] index in
//        guard let self = self else { return }
//        var model = self.blockList[index]
//        if self.searchQuery != nil {
//            model = self.getFilteredBlockList()[index]
//        }
//
//        DispatchQueue.global().async {
//            BlasterAPI.request(UserProfileAPI.get(id: model.user.id)) { result in
//                do {
//                    let model = try result.get().decode(LiveOverlayUserModel.self)
//                    DispatchQueue.main.async {
//                        self.presentPanModal(ModerationMiniProfileController(user: model))
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        ToastController.showNotification(title: error.localizedDescription)
//                    }
//                }
//            }
//        }
    }
    
    private func setupСollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
            
    
}

// MARK: - UICollectionViewDataSource

extension LecturesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if searchQuery != nil {
            return getFilteredBlockList().count
        }
        return blockList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchQuery != nil {
            return getFilteredBlockList()[section].isShort == false ? 2 : 1
        }
        return blockList[section].isShort == false ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var model = blockList[indexPath.section]
        if searchQuery != nil {
            model = getFilteredBlockList()[indexPath.section]
        }
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MutedUserCell.description(), for: indexPath) as! MutedUserCell
            
            cell.arrowImageView.transform = model.isShort == false ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
            cell.arrowImageView.tintColor = model.isShort == false ? .white : UIColor(hex6: 0xEBEBF5).withAlphaComponent(0.3)
            cell.avatarImageView.kf.setImage(with: model.user.avatar)
            cell.untilLabel.text = getEndString(end: model.end)
            cell.nameLabel.text = model.user.name
            cell.descriptionLabel.attributedText = getDescString(authorName: model.moderator.name, reason: model.reasonId)
            cell.bannedAtLabel.text = getTimeString(start: model.start)
            cell.avatarAction = miniProfileAction
            cell.avatarImageView.tag = indexPath.section
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlockStreamReportsCell.description(), for: indexPath) as! BlockStreamReportsCell
            
            cell.reportStack.removeAllArrangedSubviews()
            cell.streamNameStack.removeAllArrangedSubviews()
            cell.setupReports(reports: model.reports)
            cell.setupStreamName(name: model.name, startStream: model.start, endStream: model.end)
            cell.previews = model.previews
            cell.unbanButton.tag = indexPath.section
            cell.unbanButton.addTarget(self, action: #selector(unbanButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as! MutedUserCell
        cell.rotateArrow()
        var model = blockList[indexPath.section]
        if searchQuery != nil {
            model = getFilteredBlockList()[indexPath.section]
        }
        
        collectionView.performBatchUpdates {
            if model.isShort == false {
                collectionView.deleteItems(at: [IndexPath(item: 1, section: indexPath.section)])
                model.isShort = true
            } else {
                collectionView.insertItems(at: [IndexPath(item: 1, section: indexPath.section)])
                model.isShort = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var model = blockList[indexPath.section]
        if searchQuery != nil {
            model = getFilteredBlockList()[indexPath.section]
        }
        
        return model.isShort == false ? CGSize(width: UIScreen.main.bounds.width, height: 150 + 70 + 160) : CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.searchBar.resignFirstResponder()
    }
}
