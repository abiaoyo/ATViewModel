//
//  ATCollectionViewModel.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATCollectionItemViewModel: NSObject, ATCollectionItemProtocol {
    @objc dynamic public var kvoRefreshFlag: Any?
    
    public var cellId: String = ""
    
    public var onDidSelectItemBlock: ATCollectionItemDidSelectBlock?
    
    public var data: Any?
    
    public var itemSize: CGSize = CGSize.zero
    
    public func createLayout() {
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.width, height: 100)
    }
}

public class ATCollectionSectionViewModel: NSObject, ATCollectionSectionProtocol {
    
    public var itemArray: Array<ATCollectionItemProtocol> = Array<ATCollectionItemProtocol>.init()
    
    public var sectionInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    public var minimumLineSpacing: CGFloat = 0
    
    public var minimumInteritemSpacing: CGFloat = 0
    
    public var headerId: String?
    
    public var footerId: String?
    
    public var headerSize: CGSize = CGSize.zero
    
    public var footerSize: CGSize = CGSize.zero
    
    public var onDidSelectSectionHeaderBlock: ATCollectionSectionDidSelectBlock?
    
    public var onDidSelectSectionFooterBlock: ATCollectionSectionDidSelectBlock?
    
    public var data: Any?
    
    public func createLayout() {
        
    }
    
}







public class ATCollectionViewModel: NSObject {

    private var _viewProxy:ATCollectionViewProxy? = nil
    
    public var viewProxy:ATCollectionViewProxy {
        get{
            return self._viewProxy!
        }
    }
    
    public weak var delegate:ATStateProtocol? = nil
    
    public override init() {
        self._viewProxy = ATCollectionViewProxy.init()
    }
    
    init(viewProxy:ATCollectionViewProxy) {
        self._viewProxy = viewProxy
    }

    public func refreshState(state:String,msg:String?,data:Any?) -> Void {
        if let delegate:ATStateProtocol = self.delegate {
            delegate.didChangeState(state: state, msg: msg, data: data)
        }
    }
    
}
