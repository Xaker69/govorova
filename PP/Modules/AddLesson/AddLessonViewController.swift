import UIKit
import RealmSwift

class AddLessonViewController: UIViewController {
    
    let name: String
    let datePicker = UIDatePicker()
    var isStartChoosing = false
    var startDate: Date?
    var endDate: Date?
    
    var mainView: AddLessonView {
        return view as! AddLessonView
    }
    
    init(lecture name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = AddLessonView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.timeStartTextField.addTarget(self, action: #selector(showDatePicker), for: .editingDidBegin)
        mainView.timeEndTextField.addTarget(self, action: #selector(showDatePicker), for: .editingDidBegin)
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        mainView.addGestureRecognizer(gesture)
    }
    
    @objc private func viewTapped() {
        for subview in view.subviews {
            subview.resignFirstResponder()
        }
    }
    
    @objc private func showDatePicker(_ sender: UITextField) {
        
        isStartChoosing = sender == mainView.timeStartTextField
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        sender.inputAccessoryView = toolbar
        sender.inputView = datePicker
        
    }
    
    @objc func donedatePicker(_ sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        if isStartChoosing {
            mainView.timeStartTextField.text = formatter.string(from: datePicker.date)
            startDate = datePicker.date
        } else {
            mainView.timeEndTextField.text = formatter.string(from: datePicker.date)
            endDate = datePicker.date
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc private func saveButtonTapped() {
        guard let typeLesson = mainView.typeLessonTextField.text, !typeLesson.isEmpty else {
            mainView.typeLessonTextField.shakeAnimateion()
            return
        }
        guard let startDate = startDate else {
            mainView.timeStartTextField.shakeAnimateion()
            return
        }
        guard let endDate = endDate else {
            mainView.timeEndTextField.shakeAnimateion()
            return
        }
        guard let dayOfWeek = mainView.dayOfWeekTextField.text, !dayOfWeek.isEmpty else {
            mainView.dayOfWeekTextField.shakeAnimateion()
            return
        }
        guard let groupNumberString = mainView.groupNumberTextField.text, let groupNumber = Int(groupNumberString) else {
            mainView.groupNumberTextField.shakeAnimateion()
            return
        }
        guard let lessonName = mainView.nameTextField.text, !lessonName.isEmpty else {
            mainView.nameTextField.shakeAnimateion()
            return
        }
        guard let codeLessonString = mainView.codeField.text, let codeLesson = Int(codeLessonString) else {
            mainView.codeField.shakeAnimateion()
            return
        }
        guard let audienceNumberString = mainView.audienceNumberField.text, let audienceNumber = Int(audienceNumberString) else {
            mainView.audienceNumberField.shakeAnimateion()
            return
        }
        guard let audienceType = mainView.audienceTypeField.text , !audienceType.isEmpty else {
            mainView.audienceTypeField.shakeAnimateion()
            return
        }
        guard let audienceRoominessString = mainView.audienceRoominessField.text, let audienceRoominess = Int(audienceRoominessString) else {
            mainView.audienceRoominessField.shakeAnimateion()
            return
        }
        
        let audience = AudienceModel()
        audience.roominess = audienceRoominess
        audience.type = audienceType
        audience.roomNumber = audienceNumber
        
        let lesson = LessonModel()
        lesson.audience = audience
        lesson.name = lessonName
        lesson.code = codeLesson
        lesson.groupNumber = groupNumber
        lesson.dayOfWeek = dayOfWeek
        lesson.timeEnd = endDate
        lesson.timeStart = startDate
        lesson.type = typeLesson
        
        let realm = try! Realm()
        
        if let lecture = Array(realm.objects(LectureModel.self)).first(where: { $0.name == name }) {
            try! realm.write {
                lecture.lessons.append(lesson)
            }
        }
        
        dismiss(animated: true)
    }
    
}
