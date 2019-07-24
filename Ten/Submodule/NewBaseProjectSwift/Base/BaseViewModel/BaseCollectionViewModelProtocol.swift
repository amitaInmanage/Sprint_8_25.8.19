//
//  BaseCollectionViewModelProtocol.swift
//  viewModelBase
//
//  Created by aviv frenkel on 20/07/2018.
//  Copyright © 2018 aviv frenkel. All rights reserved.
//
// BaseTableViewDataSourceModelProtocol is a protocol which should be implemented,
// if the viewController got a UITableView inside him.

import Foundation
import UIKit

@objc protocol BaseCollectionViewModelProtocol : NSObjectProtocol {
    func viewModelCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    
   
    func viewModelCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    
    @objc optional func viewModelCollectionView(in collectionView: UICollectionView) -> Int
    
    
  
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    

    @objc optional func  viewModelIndexTitles(for collectionView: UICollectionView) -> [String]?
    

    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath
}



@objc protocol BaseCollectionViewModelDelegateProtocol : NSObjectProtocol {
    

    @objc optional  func viewModelCollectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath)
    
   @objc  optional func viewModelCollectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool // called when the user taps on an already-selected item in multi-select mode
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)
    
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
    

    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout
    
   
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    
    @objc optional func viewModelindexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath?
    
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath
    
    
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint
    
  
    @available(iOS 11.0, *)
    @objc optional func viewModelCollectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
}
