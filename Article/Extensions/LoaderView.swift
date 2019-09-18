import UIKit

class LoaderView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        refresh?()
    }
    
    var refresh: (() -> Void)?
    
    class func showIndicator(_ onView: UIView) {
        let customView = LoaderView.loadNib()
        customView.createView(customView, message: nil, isShowIndicator: true, isShowMessage: false, onView: onView)
    }
    
    class func showSearchIndicator(_ onView: UIView) {
        let customView = LoaderView.loadNib()
        customView.createSearchView(customView, message: nil, isShowIndicator: true, isShowMessage: false, onView: onView)
    }
    
    class func showMessage(_ message: String?, onView: UIView, isSearch: Bool, completion: @escaping (() -> Void)) {
        let customView = LoaderView.loadNib()
        if isSearch {
            customView.createSearchView(customView, message: message, isShowIndicator: false, isShowMessage: true, onView: onView)
        } else {
            customView.createView(customView, message: message, isShowIndicator: false, isShowMessage: true, onView: onView)
        }
        customView.refresh = completion
        onView.isUserInteractionEnabled = true
    }
    
    func createView(_ customView: LoaderView, message: String?, isShowIndicator: Bool, isShowMessage: Bool, onView: UIView) {
        LoaderView.remove(onView)
        customView.frame = CGRect(x: 20, y: onView.frame.height/2 - 60, width: onView.frame.width - 40, height: 120)
        customView.messageLabel.text = message
        customView.messageLabel.isHidden = isShowIndicator
        customView.activityIndicator.isHidden = isShowMessage
        onView.addSubview(customView)
        onView.isUserInteractionEnabled = false
    }
    
    func createSearchView(_ customView: LoaderView, message: String?, isShowIndicator: Bool, isShowMessage: Bool, onView: UIView) {
        LoaderView.remove(onView)
        customView.frame = CGRect(x: isShowMessage ? 20 : -20, y: 30, width: onView.frame.width - 40, height: 60)
        customView.messageLabel.text = message
        customView.messageLabel.isHidden = isShowIndicator
        customView.activityIndicator.isHidden = isShowMessage
        customView.loadingLabel.isHidden = isShowMessage
        onView.addSubview(customView)
    }
    
    class func loadNib() -> LoaderView {
        guard let loaderView = Bundle.main.loadNibNamed("LoaderView", owner: self, options: nil)?.first as? LoaderView else {
            return LoaderView()
        }
        return loaderView
    }
    
    class func remove(_ view: UIView?) {
        view?.isUserInteractionEnabled = true
        if let subViewArray = view?.subviews {
            for subView in subViewArray where subView is LoaderView {
                subView.removeFromSuperview()
            }
        }
    }
}
