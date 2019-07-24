//
//  ViewModel.swift
//  viewModelBase
//
//  Created by aviv frenkel on 01/08/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//

import Foundation
import UIKit

class ViewModel: BaseViewModel, BaseTableViewDelegateModelProtocol, BaseViewModelDataFetchProtocol {
    
    
    override init() {
        super.init()
        self.baseTableViewDelegateModelProtocol = self
        self.baseViewModelDataFetchProtocol = self
    }
    

    
    func viewModelTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func viewModelTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    
    override func viewModelDidLoad() {
        
    }
    
    override func viewModelWillAppear(_ animated: Bool) {
        
    }
    
    
    func fetchDataFromServerWith(dict: [String : String], calledObject: AnyObject, showHud: Bool, ServerRequest: AnyObject, completion: (Any) -> Void) {
        
    }
    
}
