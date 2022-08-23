import UIKit
import SnapKit

class ToDoViewController: UIViewController {
  private lazy var categoriesCollectionView = CategoriesCollectionView(frame: .zero, collectionViewLayout: CategoriesCollectionViewLayout())
  lazy var taskTableView = TasksTableView()
//  private lazy var vm = ToDoViewModel()

  private lazy var addTaskButton: UIButton = {
    let addTaskButton = UIButton(type: .system)
    
    addTaskButton.backgroundColor = #colorLiteral(red: 0.1962543428, green: 0.8419759274, blue: 0.2951532304, alpha: 1)
    addTaskButton.setTitle("+", for: .normal)
    addTaskButton.setTitleColor(.white, for: .normal)
    addTaskButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    addTaskButton.layer.cornerRadius = 5
    addTaskButton.addTarget(self, action: #selector(didTapAddTaskButton), for: .touchUpInside)
    
    return addTaskButton
  }()
  
  private let categoriesTitle: UILabel = {
    let categoriesTitle = UILabel()
    categoriesTitle.text = "Categories"
    categoriesTitle.font = UIFont.systemFont(ofSize: 20)
    
    return categoriesTitle
  }()
  
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.vertical
    stackView.distribution = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing = 24.0
    
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    addStackView()
    setupCategoriesTitle()
    
//    vm.delegate = self
  }
  
  private func setupViews() {
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9982756558)
    
    let menuBarItem = UIBarButtonItem(customView: addTaskButton)
    
    navigationItem.rightBarButtonItem = menuBarItem
    navigationItem.title = "Tasks"
  }
  
  private func setupCategoriesTitle() {
    categoriesTitle.snp.makeConstraints { make in
      make.left.equalTo(16)
    }
  }
  
  private func addStackView() {
    stackView.addArrangedSubview(categoriesTitle)
    stackView.addArrangedSubview(categoriesCollectionView)
    stackView.addArrangedSubview(taskTableView)
    
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stackView)
    
    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
  }
  
  @objc private func didTapAddTaskButton() {
    let createNewTaskVC = CreateNewTaskViewController()
    navigationController?.pushViewController(createNewTaskVC, animated: true)
  }
}
