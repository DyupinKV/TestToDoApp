import UIKit

class MainViewController: UIViewController {
  private lazy var toDoListButton:UIButton = createCustomButton(title: "ToDo list",
                                                                bgСolor: UIColor(rgb: 0x0A60FF),
                                                                selector: #selector(didTapToDoList))
  
  private lazy var categoriesListButton:UIButton = createCustomButton(title: "ToDo categories list",
                                                                      bgСolor: UIColor(rgb: 0xF090D4),
                                                                      selector: #selector(didTapToDoCategoriesList))
  
  private lazy var imagesListButton:UIButton = createCustomButton(title: "Images list",
                                                                  bgСolor: UIColor(rgb: 0xAA83E5),
                                                                  selector: #selector(didTapImagesList))
  
  private var viewModel: MainViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButtonsStack()
  }
  
  func configureButtonsStack() {
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9982756558)
    navigationItem.title = "Todo List"
    
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.vertical
    stackView.distribution = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing = 16.0
    stackView.addArrangedSubview(toDoListButton)
    stackView.addArrangedSubview(categoriesListButton)
    stackView.addArrangedSubview(imagesListButton)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stackView)
    
    stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
  }
  
  @objc func didTapToDoList() {
    let toDoVC = ToDoViewController()
    navigationController?.pushViewController(toDoVC, animated: true)
  }
  
  @objc func didTapToDoCategoriesList() {
    let toDoCategoriesVC = ToDoCategoriesViewController()
    navigationController?.pushViewController(toDoCategoriesVC, animated: true)
  }
  
  @objc private func didTapImagesList() {
    let imagesVC = ImagesViewController()
    navigationController?.pushViewController(imagesVC, animated: true)
  }
}
