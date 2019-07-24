//
//  BaseViewModel.swift
//  viewModelBase
//
//  Created by aviv frenkel on 13/07/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//
// the BaseViewModel Contains Protocols which can be added to and changed.
// and contains functions relevent to their names,
// which then can be implemented in the override init().
// if one desires to implement the protocols methods

import UIKit



class BaseViewModel: NSObject, BaseFunctionsViewModelDataSource {
    
    var baseFunctionsViewModelDataSourceDelegate : BaseFunctionsViewModelDataSource?
    var baseTableViewDataSourceModelProtocol : BaseTableViewDataSourceModelProtocol?
    var baseTableViewDelegateModelProtocol : BaseTableViewDelegateModelProtocol?
    var baseCollectionViewModelProtocol : BaseCollectionViewModelProtocol?
    var baseCollectionViewModelDelegateProtocol : BaseCollectionViewModelDelegateProtocol?
    var baseViewModelDataFetchProtocol : BaseViewModelDataFetchProtocol?
    var baseViewModelDataFetchProtocolToController : BaseViewModelDataFetchProtocolToController?


    override init() {
        super.init()
        self.baseFunctionsViewModelDataSourceDelegate = self
    }
    
    
    
    //MARK: -BaseFunctionsViewModelDataSource
    
    func viewModelDidLoad() {
        
    }
    
    func viewModelWillAppear(_ animated: Bool) {
        
    }
    
    func viewModelDidAppear(_ animated: Bool) {
        
    }
    
    func viewModelWillDisappear(_ animated: Bool) {
        
    }
    
    func viewModelDidDisappear(_ animated: Bool) {
        
    }
    
    
}
