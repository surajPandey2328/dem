//
//  DashboardViewController.swift
//  Article
//
//  Created by Sudhir on 10/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit
import SwiftyJSON

class DashboardViewController: UIViewController {
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Private Var
    var getArticles = GetArticlesList(JSON())
    //var markFavData = MarkArtistFavResponseList(JSON())

    private var dashboardData = Constants.AppData.dashboardData
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllStreams()
        setupData()
    }

    // MARK: - Custom Methods
    func setupData() {
        // Update UI with data
    }
}

extension DashboardViewController: UITableViewDataSource {
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dashboardData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dashboardData[section]["value"] as? [String])?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.docCell)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: Constants.CellIdentifiers.docCell)
        }
        let viewModel = DashboardViewModel(text: (dashboardData[indexPath.section]["value"] as? [String])?[indexPath.row] ?? "")
        cell?.textLabel?.text = viewModel.cellTitle
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dashboardData[section]["title"] as? String
    }
}

extension DashboardViewController:UITableViewDelegate {
    //MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let viewModel = DashboardViewModel(text: (dashboardData[indexPath.section]["value"] as? [String])?[indexPath.row] ?? "")
      
        if viewModel.cellTitle! == "Login"{
            print("login id")
            self.showLoader()
            ArticleWebServices.shared.login(controller: self, parameters: loginData(), completion: { [weak self] (json, error) in
                
                guard let `self` = self, error == nil else {
                    return
                    
                }
                self.handleLoginResponse(json)
            })
            
        }
        
        
        
        if viewModel.cellTitle! == "Registration"{
            print("Registration id")
            self.showLoader()
            ArticleWebServices.shared.Registration(controller: self, parameters: RegistrationData(), completion: { [weak self] (json, error) in
                
                guard let `self` = self, error == nil else {
                    return
                
                }
                self.handleRegistrationResponse(json)
            })
            
        }
        
        
    }
}

extension DashboardViewController {
    // MARK: - WebServices
    //Fetch Streams
    private func fetchAllStreams(){
        showLoader()
        ArticleWebServices.shared.getFavArticles(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefavoritesArtistResponse(json)
        })
    }
    
    private func handlefavoritesArtistResponse(_ json: JSON) {
        hideLoader()
        let jsonObject = JSON(json)
        let model = RootClass(jsonObject)
        print(model.kstream?.streamData![0].articleType)
    }
    
    
    //Login
    private func loginData() -> [String: Any] {
//        let email = emailTextFeild.text?.trim() ?? ""
//        let password = passwordTextFeild.text?.trim() ?? ""
        return ["email": "sudhir@gmail.com" , "password": "akjshdlaks"]
    }
    
    private func RegistrationData() -> [String: Any] {
        //        let email = emailTextFeild.text?.trim() ?? ""
        //        let password = passwordTextFeild.text?.trim() ?? ""
        return [
            "name":"srj pngy",
            "email":"srj1@gmail.com",
            "password":"akjshdlaks",
            "password_confirmation":"akjshdlaks",
            "mobile":"9030234222",
            "gender":"Male"
            ]
    }
    
    
    private func handleLoginResponse(_ json: JSON) {
        hideLoader()
        let jsonObject = JSON(json)
        let user = User(jsonObject)
        print(user.name)
        
    }
    
    private func handleRegistrationResponse(_ json: JSON) {
        hideLoader()
        print(json)
        let jsonObject = JSON(json)
      
        showAlertViewWithMessageAndActionHandler(message: jsonObject["message"].stringValue) {
            
        }
        
    }
    
    //Registration
    
    
    
    
    
    
}
