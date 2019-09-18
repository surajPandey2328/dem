//
//  SearchViewController.swift
//  Article
//
//  Created by Sudhir on 10/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit
import  SwiftyJSON
class SearchViewController: UIViewController , UITextFieldDelegate {
    // IBOutlets
    var articlesList : [Docs] = []
    @IBOutlet weak var txtFieldSearch: UITextField!
    // iVar
    
    // Private Var
    
    // Computed Var
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
    
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController
        vc?.articlesList = articlesList
        vc?.searchText = txtFieldSearch.text 
        vc?.type = .search
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        return true
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

extension SearchViewController: UITableViewDataSource {
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:"Identifier") as? UITableViewCell {
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchViewController {
    // MARK: - WebServices
}
