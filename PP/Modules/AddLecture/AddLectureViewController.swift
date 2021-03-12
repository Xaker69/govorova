import PanModal
import RealmSwift

class AddLectureViewController: UIViewController {
    var name = ""
    var bottomPadding: CGFloat = 0
    var keyboardHeight: CGFloat = 0
    var nameChangedAction: () -> () = {}
    
    private var mainView: AddLectureView {
        return view as! AddLectureView
    }
    
    override func loadView() {
        let view = AddLectureView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nameTextField.placeholder = name
        mainView.nameTextField.text = name
        
        mainView.saveButton.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        
        mainView.nameTextField.addTarget(self,action: #selector(nameChanging),for: .editingChanged)
        
        mainView.nameTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyboardHeight = keyboardHeight
        }
        
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    @objc private func nameChanging(_ sender: UITextField) {
        name = sender.text ?? ""
        if sender.text == "" {
            name = "Виталий"
        }
    }
    
    @objc private func changeName() {
        let realm = try! Realm()
        let lecture = LectureModel()
        lecture.name = name
        
        try! realm.write({
            realm.add(lecture)
        })
        
        self.nameChangedAction()
        self.dismiss(animated: true)
    }
    
}


extension AddLectureViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var longFormHeight: PanModalHeight {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }
        return .contentHeight(207 + keyboardHeight)
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    var cornerRadius: CGFloat {
        return 15
    }
    var backgroundAlpha: CGFloat {
        return 0.4
    }
    var showDragIndicator: Bool {
        return false
    }
    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.allowAnimatedContent]
    }
}
