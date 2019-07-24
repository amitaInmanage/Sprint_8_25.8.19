//
//  BaseFunctionsViewModelDataSource.swift
//  viewModelBase
//
//  Created by aviv frenkel on 13/07/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//
// BaseFunctionsViewModelDataSource contains all the functions
// which should be called on the controller load.

import UIKit

protocol BaseFunctionsViewModelDataSource: NSObjectProtocol {
    
    /*
    * viewModelDidLoad should be called on the ViewDidLoad ViewController Function.
    *
    */
    func viewModelDidLoad()
    /*
     * viewModelWillAppear should be called on the viewWillAppear ViewController Function.
     *
     */
    func viewModelWillAppear(_ animated: Bool)
    /*
     * viewModelDidAppear should be called on the viewDidAppear ViewController Function.
     *
     */
    func viewModelDidAppear(_ animated: Bool)
    /*
     * viewModelWillDisappear should be called on the viewWillDisappear ViewController Function.
     *
     */
    func viewModelWillDisappear(_ animated: Bool)
    /*
     * viewModelDidDisappear should be called on the viewDidDisappear ViewController Function.
     *
     */
    func viewModelDidDisappear(_ animated: Bool)
    
}
