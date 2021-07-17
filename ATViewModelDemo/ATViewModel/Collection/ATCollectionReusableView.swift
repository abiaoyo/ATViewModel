//
//  ATCollectionReusableView.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATCollectionReusableView: UICollectionReusableView, ATCollectionReuseableViewProtocol {
    
    public var indexPath: IndexPath?
    
    public var sectionVM: ATCollectionSectionProtocol?
    
    public func configVM(sectionVM: ATCollectionSectionProtocol, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.sectionVM = sectionVM
        self.refreshSubviews(isKvo: false)
    }
    
    func refreshSubviews(isKvo:Bool){
        
    }
}
