//
//  ATViewModel.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit


public class ATViewModel: ATViewModelProtocol {
    
    public var data: Any?
    
    public weak var delegate:ATStateProtocol? = nil
    
    public func createLayout() {
        
    }
    
    public func refreshState(state:String,msg:String?,data:Any?) -> Void {
        if let delegate:ATStateProtocol = self.delegate {
            delegate.didChangeState(state: state, msg: msg, data: data)
        }
    }
}
