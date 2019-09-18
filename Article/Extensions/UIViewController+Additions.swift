
import UIKit
import SVProgressHUD
extension UIViewController {
    
    //    class var storyboardID: String {
    //        return "\(self)"
    //    }
    
    func showLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setForegroundColor(ArticleArt.Color.black)
            SVProgressHUD.setBackgroundColor(UIColor.white.withAlphaComponent(0.9))
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func showAlertViewWithMessageAndActionHandler(_ title: String = "Success", message: String, actionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default) { _ in
            if let _ = actionHandler {
                actionHandler!()
            }
        }
        alertController.addAction(alAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithSuccessMessageAndActionHandler(_ title: String = "Success", message: String, actionHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default) { _ in
            if let _ = actionHandler {
                actionHandler!()
            }
        }
        alertController.addAction(alAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertViewWithMessageAndTwoActionHandler(_ title: String,_ leftTitle: String = "No",_ rightTitle: String = "Yes" ,message: String, leftActionHandler: (() -> Void)?,rightActionHandler:(() -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let leftAction = UIAlertAction(title: NSLocalizedString(leftTitle, comment: leftTitle), style: .default) { _ in
            if let _ = leftActionHandler {
                leftActionHandler!()
            }
        }
        let rightAction = UIAlertAction(title: NSLocalizedString(rightTitle, comment: rightTitle), style: .destructive) { _ in
            if let _ = rightActionHandler {
                rightActionHandler!()
            }
        }
        alertController.addAction(leftAction)
        alertController.addAction(rightAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
