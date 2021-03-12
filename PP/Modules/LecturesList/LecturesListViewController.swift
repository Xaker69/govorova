import UIKit
import RealmSwift
class LecturesListViewController: UIViewController, ContainerPageable {

    var index: Int {
        return 0
    }
    
    var dictionary = [Int: Bool]()
    
    private var lectureList: [LectureModel] {
        let realm = try! Realm()
        
        return Array(realm.objects(LectureModel.self))
    }
        
    private var mainView: LecturesListView {
        return view as! LecturesListView
    }
    
    override func loadView() {
        let view = LecturesListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        refreshControl.tintColor = UIColor.white.withAlphaComponent(0.8)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        mainView.collectionView.refreshControl = refreshControl
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        setupСollectionView()
    }
    
    @objc private func refresh() {
        mainView.collectionView.reloadData()
        mainView.collectionView.refreshControl?.endRefreshing()
    }
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        let vc = AddLectureViewController()
        vc.nameChangedAction = { [weak self] in
            self?.mainView.collectionView.reloadData()
        }
        presentPanModal(vc)
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        let vc = AddLessonViewController(lecture: lectureList[sender.tag].name)
        present(vc, animated: true)
    }
    
    private func setupСollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension LecturesListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return lectureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictionary[section] == false ? 2 : 1
//        return dictionary[section] == false ? lectureList[section].lessons.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = lectureList[indexPath.section]
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LectureCell.description(), for: indexPath) as! LectureCell
            
            cell.titleLabel.text = model.name
            cell.moreButton.tag = indexPath.section
            cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SheduleCell.description(), for: indexPath) as! SheduleCell
            
            cell.dayOfWeekLabel.text = model.lessons[indexPath.item - 1].dayOfWeek
            cell.roomNumber.text = model.lessons[indexPath.item - 1].audience.roomNumber.description
            cell.titleLabel.text = model.lessons[indexPath.item - 1].name
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: indexPath.section)) as! LectureCell
        cell.rotateArrow()
//        let model = lectureList[indexPath.section]
        
        collectionView.performBatchUpdates {
            if dictionary[indexPath.section] == false {
//                var indexArray = [IndexPath]()
//                for (index, _) in model.lessons.enumerated() {
//                    indexArray.append(IndexPath(item: index, section: indexPath.section))
//                }
//                collectionView.deleteItems(at: indexArray)
                collectionView.deleteItems(at: [IndexPath(item: 1, section: indexPath.section)])
                
                dictionary[indexPath.section] = true
            } else {
//                var indexArray = [IndexPath]()
//                for (index, _) in model.lessons.enumerated() {
//                    indexArray.append(IndexPath(item: index, section: indexPath.section))
//                }
//                collectionView.insertItems(at: indexArray)
                collectionView.insertItems(at: [IndexPath(item: 1, section: indexPath.section)])
                
                dictionary[indexPath.section] = false
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var model = blockList[indexPath.section]
//        if searchQuery != nil {
//            model = getFilteredBlockList()[indexPath.section]
//        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}
