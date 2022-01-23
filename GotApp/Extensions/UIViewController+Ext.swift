import UIKit

let isItDarkMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? true : false

extension UIViewController {
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func setStatusBar() {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusbarView = UIView(frame: frame)
        
        if isItDarkMode {
            statusbarView.backgroundColor = .black
        } else {
            statusbarView.backgroundColor = .white
        }
        view.addSubview(statusbarView)
    }
    
}
