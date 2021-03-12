import UIKit
import RealmSwift

class AudienceListViewController: UIViewController, ContainerPageable {
    
    var index: Int {
        return 1
    }
    
    private var audienceList: [AudienceModel] = {
        let realm = try! Realm()
        let lectures = Array(realm.objects(LectureModel.self))
        var audiences = [AudienceModel]()
        
        for lecture in lectures {
            for lesson in lecture.lessons {
                if !audiences.map({ $0.roomNumber }).contains(lesson.audience.roomNumber) && lesson.audience.roomNumber != 0 {
                    audiences.append(lesson.audience)
                }
            }
        }
        
        return audiences
    }()
        
    private var mainView: AudienceListView {
        return view as! AudienceListView
    }
    
    override func loadView() {
        let view = AudienceListView()
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
    }

    @objc private func refresh() {
        mainView.collectionView.reloadData()
    }
    
    private func setupСollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension AudienceListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return audienceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var model = audienceList[indexPath.section]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AudienceListCell.description(), for: indexPath) as! AudienceListCell
        
        cell.titleLabel.text = "Аудитория \(model.roomNumber)"
        cell.numberLabel.text = "\(model.roominess)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as! MutedUserCell
//        cell.rotateArrow()
//        var model = blockList[indexPath.section]
//        if searchQuery != nil {
//            model = getFilteredBlockList()[indexPath.section]
//        }
//
//        collectionView.performBatchUpdates {
//            if model.isShort == false {
//                collectionView.deleteItems(at: [IndexPath(item: 1, section: indexPath.section)])
//                model.isShort = true
//            } else {
//                collectionView.insertItems(at: [IndexPath(item: 1, section: indexPath.section)])
//                model.isShort = false
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var model = blockList[indexPath.section]
//        if searchQuery != nil {
//            model = getFilteredBlockList()[indexPath.section]
//        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}

