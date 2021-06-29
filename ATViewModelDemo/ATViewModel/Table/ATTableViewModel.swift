//
//  ATTableViewModel.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATTableRowViewModel: NSObject, ATTableRowProtocol {
    
    @objc dynamic public var kvoRefreshFlag: Any?

    public var data: Any?
    
    public var cellId: String = ""
    
    public var rowHeight: CGFloat = 60
    
    public var selectionStyle: UITableViewCell.SelectionStyle = .none
    
    public var deselectRowAfterDidSelect: Bool = true
    
    public var onDidSelectRowBlock: ATTableRowDidSelectBlock?
    
    public func createLayout() {
        
    }
}

public class ATTableSectionViewModel: NSObject, ATTableSectionProtocol {
    
    public var data: Any?
    
    public var rowArray: Array<ATTableRowProtocol> = Array<ATTableRowProtocol>.init()
    
    public var headerId: String?

    public var footerId: String?
    
    public var headerHeight: CGFloat = 0
    
    public var footerHeight: CGFloat = 0
    
    public var onDidSelectSectionHeaderBlock: ATTableSectionDidSelectBlock?
    
    public var onDidSelectSectionFooterBlock: ATTableSectionDidSelectBlock?
    
    public func createLayout() {
        
    }
    
}



public class ATTableViewModel: NSObject {
    
    private var _viewProxy:ATTableViewProxy? = nil
    
    public var viewProxy:ATTableViewProxy {
        get{
            return self._viewProxy!
        }
    }
    
    public weak var delegate:ATStateProtocol? = nil
    
    public override init() {
        self._viewProxy = ATTableViewProxy.init()
    }
    
    init(viewProxy:ATTableViewProxy) {
        self._viewProxy = viewProxy
    }

    public func refreshState(state:String,msg:String?,data:Any?) -> Void {
        if let delegate:ATStateProtocol = self.delegate {
            delegate.didChangeState(state: state, msg: msg, data: data)
        }
    }
    
}
