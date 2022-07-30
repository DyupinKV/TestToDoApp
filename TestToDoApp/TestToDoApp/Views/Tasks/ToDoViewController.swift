import UIKit

class ToDoViewController: UIViewController {
  private lazy var realmManager = RealmManager()
  
  private var taskCollectionView: UICollectionView!
  private var categoriesCollectionView: UICollectionView!
  
  var vm = ToDoViewModel()
  private lazy var tasks:[Task] = []
  private lazy var categories:[String] = vm.categories
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    vm.delegate = self
    vm.getData()
    setupCategoriesCollectionView()
    setupTasksCollectionView()
  }
  
  private func setupViews() {
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9982756558)
    
    createCustomNavigationBar()
    
    let addTaskButton = createCustomButton(title: "+",
                                           bgСolor: UIColor(rgb: 0x30D33B),
                                           selector: #selector(didTapAddTaskButton),
                                           width: 60)
    
    let menuBarItem = UIBarButtonItem(customView: addTaskButton)
    
    navigationItem.rightBarButtonItem = menuBarItem
    navigationItem.title = "Tasks"
    
    let view = UIView()
    view.backgroundColor = .white
  }
  
  func setupTasksCollectionView () {
    taskCollectionView = UICollectionView( frame: .zero, collectionViewLayout: createTasksListLayout())
    taskCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    taskCollectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
    taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.reuseIdentifier)
    taskCollectionView.backgroundColor = UIColor.white
    
    taskCollectionView.dataSource = self
    taskCollectionView.delegate = self
    
    view.addSubview(taskCollectionView)
    
    taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    taskCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    taskCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    taskCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
  }
  
  func setupCategoriesCollectionView () {
    categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCategoryListLayout())
    categoriesCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    categoriesCollectionView.register(SectionHeader.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: SectionHeader.reuseId)
    categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
    categoriesCollectionView.backgroundColor = UIColor.white
    
    categoriesCollectionView.dataSource = self
    categoriesCollectionView.delegate = self
    
    view.addSubview(categoriesCollectionView)
    
    categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    categoriesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    categoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
    categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
  }
  
  private func createTasksListLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(86))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8 , trailing: 0)
    
    let groupSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 20)
    
    let header = createSectionHeader()
    section.boundarySupplementaryItems = [header]
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  private func createCategoryListLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
    
    let groupSize = NSCollectionLayoutSize (widthDimension: .estimated(130), heightDimension: .estimated(54))
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 20, trailing: 12)
    
    let header = createSectionHeader()
    section.boundarySupplementaryItems = [header]
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
    
    let layoutHeaderSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                          elementKind: UICollectionView.elementKindSectionHeader,
                                                                          alignment: .top)
    
    return layoutHeaderSection
  }
  
  @objc private func didTapAddTaskButton() {
    let createNewTaskVC = CreateNewTaskViewController()
    navigationController?.pushViewController(createNewTaskVC, animated: true)
  }
}

extension ToDoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case taskCollectionView:
      return tasks.count
    default:
      return categories.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if(collectionView == taskCollectionView) {
      let task = tasks[indexPath.row]
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TaskCell.reuseIdentifier,
        for: indexPath
      ) as? TaskCell else {
        return UICollectionViewCell()
      }
      cell.configure(with: task)
      return cell
    } else {
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
  }
}

extension ToDoViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case categoriesCollectionView:
      let category = categories[indexPath.row]
      let unselectCategory = vm.tapCategory(category: category)
      let selectedCell = collectionView.cellForItem(at: indexPath)
      let cellColor = unselectCategory ? #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1) : .green
      
      selectedCell?.backgroundColor =  cellColor
      
    default:
      let task = tasks[indexPath.row]
      vm.tapTaskForComplete(taskID: task.id, newCompletedStatus: !task.completed)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if collectionView == categoriesCollectionView {
      for cell in collectionView.visibleCells {
        cell.backgroundColor =  #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
      }
    }
  }
}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: SectionHeader.reuseId,
      for: indexPath) as? SectionHeader else {
      return UICollectionReusableView()
    }
    switch collectionView {
    case taskCollectionView:
      header.title.text = "Tasks"
    default:
      header.title.text = "Categories"
    }
    return header
  }
}

extension ToDoViewController: ToDoViewModelDelegate {
  func updatedInfo() {
    DispatchQueue.main.async { [self] in
      self.tasks = vm.data
      self.taskCollectionView.reloadData()
    }
  }
}
