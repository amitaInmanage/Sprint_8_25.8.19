//
//  BaseTableViewModelProtocol.swift
//  viewModelBase
//
//  Created by aviv frenkel on 13/07/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//
// BaseTableViewDataSourceModelProtocol is a protocol which should be implemented,
// if the viewController got a UITableView inside him.

import Foundation
import UIKit

@objc protocol BaseTableViewDataSourceModelProtocol : NSObjectProtocol {
    
    func viewModelTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func viewModelTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  
    @objc optional func viewModelnumberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    
    @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    
    @objc optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    @objc optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    
   
    @objc optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    
 
    @objc optional func sectionIndexTitles(for tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    
    @objc optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
 
    @objc optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    

    @objc optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    
}

@objc protocol BaseTableViewDelegateModelProtocol : NSObjectProtocol {
    @objc optional func viewModelTableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func viewModelTableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    
    @objc optional func viewModelTableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    
    @objc optional func viewModelTableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @objc optional func viewModelTableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    
    @objc optional func viewModelTableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
}
