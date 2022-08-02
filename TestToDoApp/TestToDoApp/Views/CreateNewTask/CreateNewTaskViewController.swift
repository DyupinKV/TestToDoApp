import UIKit

class CreateNewTaskViewController: UIViewController {
  
  private let titleLabel:UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Task name:"
    titleLabel.font = UIFont.systemFont(ofSize: 20)
    
    return titleLabel
  }()
  
  private var titleInput: UITextField = {
    let titleInput = UITextField()
    
    titleInput.placeholder = "Enter task name"
    titleInput.font = UIFont.systemFont(ofSize: 16)
    titleInput.layer.borderWidth = 1
    titleInput.layer.cornerRadius = 5
    titleInput.textAlignment = .center
    
    return titleInput
  }()
  
  private let dateLabel:UILabel = {
    let dateLabel = UILabel()
    dateLabel.text = "Choose task date:"
    dateLabel.font = UIFont.systemFont(ofSize: 20)
    
    return dateLabel
  }()
  
  private let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    datePicker.preferredDatePickerStyle = .wheels
    
    return datePicker
  }()
  
  private let categoriesTextView: UITextField = {
    let categoriesTextView = UITextField()
    
    categoriesTextView.placeholder = "Choose category"
    categoriesTextView.font = UIFont.systemFont(ofSize: 20)
    categoriesTextView.layer.borderWidth = 1
    categoriesTextView.layer.cornerRadius = 5
    categoriesTextView.textAlignment = .center
    
    return categoriesTextView
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.vertical
    stackView.distribution = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing = 24.0
    
    return stackView
  }()
  
  private let categoriesPickerView = UIPickerView()
  private lazy var taskCreateButton: UIButton = createCustomButton(title: "Create task",
                                                                   bgСolor: UIColor(rgb: 0xAA83E5),
                                                                   selector: #selector(didTapCreateButton))
  private lazy var realmManager = RealmManager()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.9906775355, green: 0.9906774163, blue: 0.9906774163, alpha: 1)
    
    navigationItem.title = "Creating new task"
    
    setupElements()
    addConstraints()
    addCategoriesPickerView()
  }
  
  private func setupElements() {
    titleInput.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(titleInput)
    stackView.addArrangedSubview(dateLabel)
    stackView.addArrangedSubview(datePicker)
    stackView.addArrangedSubview(categoriesTextView)
    stackView.addArrangedSubview(taskCreateButton)
  }
  
  private func addConstraints() {
    view.addSubview(stackView)
    
    let offset = CGFloat(40)
    
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -offset).isActive = true
    
    titleInput.heightAnchor.constraint(equalToConstant: offset).isActive = true
    titleInput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -offset).isActive = true
    
    categoriesTextView.heightAnchor.constraint(equalToConstant: offset).isActive = true
    categoriesTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -offset).isActive = true
  }
  
  @objc func didTapCreateButton() {
    let title:String = titleInput.text ?? ""
    let category:String = categoriesTextView.text ?? ""
    
    switch (title, category) {
    case ("", _):
      titleInput.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
      categoriesTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    case (_, "") :
      categoriesTextView.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
      titleInput.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    default:
      createTask(title, category)
    }
  }
  
  private func createTask(_ title: String, _ category: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let date = dateFormatter.string(from: datePicker.date)
    dateFormatter.dateFormat = "HH:MM"
    let time = dateFormatter.string(from: datePicker.date)
    realmManager.addTask(taskTitle: title, taskTime: time, taskDate: date, category: category)
    
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
    view.endEditing(true)
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

