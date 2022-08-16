import UIKit

final class ToDoViewController: UIViewController {  
  private var categoriesCollectionView: UICollectionView!
  private var taskTableView: UITableView!
  
  var vm = ToDoViewModel()
  private lazy var tasks:[Task] = []
  private lazy var categories:[String] = vm.categories
  
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
    vm.categories.insert("All categories", at: 0)
    
    setupViews()
    vm.delegate = self
    vm.getData()
    setupCategoriesCollectionView()
    setupTasksTableView()
    addStackView()
    setupCategoriesTitle()
  }
  
  private func setupViews() {
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9982756558)
    
    let menuBarItem = UIBarButtonItem(customView: addTaskButton)
    
    navigationItem.rightBarButtonItem = menuBarItem
    navigationItem.title = "Tasks"
  }
  
  func setupCategoriesTitle() {
    categoriesTitle.translatesAutoresizingMaskIntoConstraints = false
    categoriesTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
  }
  
  func setupCategoriesCollectionView () {
    categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCategoryLayout())
    categoriesCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    categoriesCollectionView.showsHorizontalScrollIndicator = false
    categoriesCollectionView.register( CategoryCell.self,
                                       forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    categoriesCollectionView.backgroundColor = UIColor.white
    
    categoriesCollectionView.dataSource = self
    categoriesCollectionView.delegate = self
    
    categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoriesCollectionView.heightAnchor.constraint(equalToConstant: 76).isActive = true
  }
  
  func setupTasksTableView() {
    taskTableView = UITableView()
    
    taskTableView.register(TasksHeader.self, forHeaderFooterViewReuseIdentifier: TasksHeader.reuseIdentifier)
    taskTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    taskTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    taskTableView.showsVerticalScrollIndicator = false
    
    taskTableView.dataSource = self
    taskTableView.delegate = self
  }
  
  
  func addStackView() {
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
  
  private func createCategoryLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 12
    layout.minimumInteritemSpacing = 12
    layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    layout.itemSize = CGSize(width: 130, height: 54)
    
    return layout
  }
  
  @objc private func didTapAddTaskButton() {
    let createNewTaskVC = CreateNewTaskViewController()
    navigationController?.pushViewController(createNewTaskVC, animated: true)
  }
}

extension ToDoViewController: UICollectionViewDataSource, UITableViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let category = categories[indexPath.row]
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CategoryCell.reuseIdentifier,
      for: indexPath
    ) as? CategoryCell else {
      return UICollectionViewCell()
    }
    cell.backgroundColor = #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    cell.configure(with: category)
    return cell
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = tasks[indexPath.row]
    
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: TaskCell.reuseIdentifier,
      for: indexPath
    ) as? TaskCell else {
      return UITableViewCell()
    }
    cell.configure(with: task)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 86
  }
}

extension ToDoViewController: UICollectionViewDelegate, UITableViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let category = categories[indexPath.row]
    let unselectCategory = vm.tapCategory(category: category)
    let selectedCell = collectionView.cellForItem(at: indexPath)
    let cellColor = unselectCategory ? #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1) : .green
    
    selectedCell?.backgroundColor = cellColor
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    for cell in collectionView.visibleCells {
      cell.backgroundColor =  #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let task = tasks[indexPath.row]
    vm.tapTaskForComplete(taskIndex: indexPath.row, newCompletedStatus: !task.completed )
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TasksHeader.reuseIdentifier) as? TasksHeader else {
      return UIView()
    }
    view.title.text = "Tasks"
    
    return view
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    vm.delete(taskIndex: indexPath.row)
  }
}

extension ToDoViewController: ToDoViewModelDelegate {
  func updatedPickedCategory() {
    for cell in categoriesCollectionView.visibleCells {
      cell.backgroundColor =  #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    }
  }
  
  func updatedInfo() {
    DispatchQueue.main.async { [self] in
      self.tasks = vm.data
      self.taskTableView.reloadData()
    }
  }
}
