import Foundation
import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}

extension UIViewController {
  
  func createCustomNavigationBar() {
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
  func createCustomButton(title:String, bgСolor: UIColor, selector: Selector, width: Int = 200) -> UIButton {
    let button = UIButton(type: .system)
    
    button.backgroundColor = bgСolor
    button.setTitle(title, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.layer.cornerRadius = 5
    button.addTarget(self, action: selector, for: .touchUpInside)
    
    button.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    
    return button
  }
}

extension UITextField {
  func setPadding(left: CGFloat, right: CGFloat? = nil) {
    setLeftPadding(left)
    if let rightPadding = right {
      setRightPadding(rightPadding)
    }
  }
  
  private func setLeftPadding(_ padding: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  
  private func setRightPadding(_ padding: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}
