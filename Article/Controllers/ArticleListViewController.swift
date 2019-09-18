//
//  ArticleListViewController.swift
//  Article
//
//  Created by Sudhir on 10/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit


class ArticleListViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableview: UITableView!
    
    // iVar
    
    // Private Var
    var articlesList : [Docs] = []
    var articlesFileteredList : [Docs] = []
    var searchText : String?
    // Computed Var
    var type : CellType?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        tableview.register(ArticleCell.nib, forCellReuseIdentifier:  Constants.CellIdentifiers.listCell)
        filterrList()
        // Do any additional setup after loading the view.
    }

    func filterrList() {
        guard let type = type else {
            return
        }
        switch type {
        case .search:
            title = "Searched Articles"
            guard let srchText = searchText, srchText != "" else {
                articlesFileteredList = articlesList
                return
            }
            articlesFileteredList = articlesList.filter({($0.headline?.main?.lowercased() ?? "").contains(srchText.lowercased()) })
        case .emailed:
            title = "Most Emailed"
            //Didn't find api to do so i filter like this
            articlesFileteredList = articlesList.filter({($0.headline?.main?.lowercased() ?? "").contains("e".lowercased()) })
        case .shared:
            title = "Most Shared"
            articlesFileteredList = articlesList.filter({($0.headline?.main?.lowercased() ?? "").contains("Ir".lowercased()) })
        case .viewed:
            title = "Most Viewed"
            articlesFileteredList = articlesList.filter({($0.headline?.main?.lowercased() ?? "").contains("re".lowercased()) })
        default:
            break
        }
        tableview.reloadData()
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Custom Methods
    func setupUI() {
        // Setup UI
    }
    
    func setupData() {
        // Update UI with data
    }
    
    // MARK: - IBActions
    
}



extension ArticleListViewController: UITableViewDataSource {
    // MARK: - TableView DataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesFileteredList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
         if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.listCell) as? ArticleCell {
            let article = articlesFileteredList[indexPath.row] as Docs
            let attributsBold = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)]
            let attributsNormal = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .regular)]
            let attributedString = NSMutableAttributedString(string: (article.headline?.main)!, attributes:attributsNormal)
            let boldStringPart = NSMutableAttributedString(string: "Title : ", attributes:attributsBold)
            boldStringPart.append(attributedString)
            cell.title.attributedText = boldStringPart
            cell.publishDate.text = "Date : " + convertDateFormater(article.pubDate ?? "")
         return cell
        }
        return  UITableViewCell()
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return  dateFormatter.string(from: date!)
    }
}

extension ArticleListViewController:UITableViewDelegate {
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertViewWithMessageAndActionHandler(message: "Not In task.") {
        }
    }
}

extension ArticleListViewController {
    // MARK: - WebServices
}
