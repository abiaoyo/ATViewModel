//
//  ATTableViewHeaderFooterView.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATTableViewHeaderFooterView: UITableViewHeaderFooterView, ATTableHeaderFooterProtocol {
    
    public var section: Int = 0
    
    public var sectionVM: ATTableSectionProtocol?
    
    public func configVM(sectionVM: ATTableSectionProtocol, section: Int) {
        self.section = section
        self.sectionVM = sectionVM
        self.refreshSubviews(isKvo: false)
    }

    public func refreshSubviews(isKvo:Bool) -> Void {
        
    }
}
