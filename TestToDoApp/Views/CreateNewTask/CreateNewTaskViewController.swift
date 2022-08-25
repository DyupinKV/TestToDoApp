import UIKit
import SnapKit

final class CreateNewTaskViewController: UIViewController {
  private lazy var vm = CreateNewTaskViewModel()
  
  private func createNewLabel(text: String = "", fontSize: CGFloat = 20, textColor: UIColor = .black) -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: fontSize)
    label.text = text
    label.textColor = textColor
    
    return label
  }
  
  private func createTextField(placeholder: String = "") -> UITextField {
    let textField = UITextField()
    
    textField.placeholder = placeholder
    textField.font = UIFont.systemFont(ofSize: 16)
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 5
    textField.textAlignment = .center
    
    return textField
  }
  
  private lazy var titleLabel = createNewLabel(text: "Task name:")
  private lazy var dateLabel = createNewLabel(text: "Choose task date:")
  private lazy var warningLabel = createNewLabel(fontSize: 14, textColor: .red)
  
  private lazy var titleInput = createTextField(placeholder: "Enter task name")
  private lazy var categoriesTextView = createTextField(placeholder: "Choose category")
  
  private lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    datePicker.preferredDatePickerStyle = .wheels
    
    return datePicker
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.vertical
    stackView.distribution = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing = 24.0
    
    return stackView
  }()
  
  private lazy var taskCreateButton: UIButton = {
    let taskCreateButton = UIButton(type: .system)
    
    taskCreateButton.backgroundColor = #colorLiteral(red: 0.1962543428, green: 0.8419759274, blue: 0.2951532304, alpha: 1)
    taskCreateButton.setTitle("Create task", for: .normal)
    taskCreateButton.setTitleColor(.white, for: .normal)
    taskCreateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    taskCreateButton.layer.cornerRadius = 5
    taskCreateButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    
    taskCreateButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
    
    return taskCreateButton
  }()
  
  private lazy var categoriesPickerView = UIPickerView()
  
  private lazy var realmManager = RealmManager<Task>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.9906775355, green: 0.9906774163, blue: 0.9906774163, alpha: 1)
    
    navigationItem.title = "Creating new task"
    
    setupStackView()
    setupElements()
  }
  
  private func setupStackView() {
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(titleInput)
    stackView.addArrangedSubview(dateLabel)
    stackView.addArrangedSubview(datePicker)
    stackView.addArrangedSubview(categoriesTextView)
    stackView.addArrangedSubview(warningLabel)
    stackView.addArrangedSubview(taskCreateButton)
    
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.centerX.equalTo(view.snp.centerX)
    }
  }
  
  private func setupElements() {
    let offset = CGFloat(40)

    addCategoriesPickerView()
    
    titleInput.snp.makeConstraints { make in
      make.height.equalTo(offset)
      make.width.equalTo(view.snp.width).offset(-offset)
    }
    
    categoriesTextView.delegate = self
    categoriesTextView.snp.makeConstraints { make in
      make.height.equalTo(offset)
      make.width.equalTo(view.snp.width).offset(-offset)
    }
    
    warningLabel.snp.makeConstraints { make in
      make.height.equalTo(offset / 2)
    }
  }
  
  @objc func didTapCreateButton() {
    let title:String = titleInput.text ?? ""
    let category:String = categoriesTextView.text ?? ""
    
    switch (title, category) {
    case ("", _):
      titleInput.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
      categoriesTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      warningLabel.text = "Please enter the title"
    case (_, "") :
      categoriesTextView.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
      titleInput.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      warningLabel.text = "Please choose category"
    default:
      createTask(title, category)
    }
  }
  
  private func createTask(_ title: String, _ category: String) {
    let newTask = Task(value: ["title": title, "category": category, "date": datePicker.date, "completed": false])
    vm.add(newTask: newTask)
    
    let toDoVC = ToDoViewController()
    navigationController?.pushViewController(toDoVC, animated: true)
  }
  
  private func addCategoriesPickerView() {
    categoriesTextView.inputView = categoriesPickerView
    
    categoriesPickerView.delegate = self
    categoriesPickerView.dataSource = self
    
    dismissPickerView()
  }
  
  private func dismissPickerView() {
    let toolBar = UIToolbar()
    toolBar.sizeToFit()
    let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeCategoriesPicker))
    let accept = UIBarButtonItem(title: "Accept", style: .plain, target: self, action: #selector(self.acceptCategoriesPicker))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    toolBar.setItems([close, space, accept], animated: true)
    toolBar.isUserInteractionEnabled = true
    categoriesTextView.inputAccessoryView = toolBar
  }
  
  @objc private func closeCategoriesPicker() {
    view.endEditing(true)
  }
  
  @objc private func acceptCategoriesPicker() {
    let selectedValue = Categories.allCases[categoriesPickerView.selectedRow(inComponent: 0)].rawValue
    categoriesTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    categoriesTextView.text = selectedValue
    closeCategoriesPicker()
  }
}

extension CreateNewTaskViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Categories.allCases[row].rawValue
  }
}

extension CreateNewTaskViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Categories.allCases.count
  }
}

extension CreateNewTaskViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    false
  }
}
