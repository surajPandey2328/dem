//
//  DashboardViewModel.swift
//  Article
//
//  Created by Sudhir on 10/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import UIKit

enum CellType:String {
    case search = "Search"
    case viewed = "Most Viewed"
    case shared = "Most Shared"
    case emailed = "Most Emailed"
    case none = "None"
}

class DashboardViewModel: NSObject {
    
    private var viewData: String?
    
    init(text:Any) {
        guard let text = text as? String else { return }
        self.viewData = text
    }
    
    var cellTitle: String? {
        return self.viewData
    }
    
    var cellType: CellType {
        return CellType(rawValue: cellTitle ?? "") ?? .none
    }
}
