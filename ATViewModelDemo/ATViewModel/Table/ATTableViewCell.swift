//
//  ATTableViewCell.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATTableViewCell: UITableViewCell, ATTableCellProtocol{
    public var rowVM: ATTableRowProtocol?
    public var indexPath: IndexPath?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
    }
    
    public func setupData(){
        
    }
    
    public func setupSubviews(){
        
    }
    
    public func setupLayout(){
        
    }
    
    public func configVM(rowVM: ATTableRowProtocol, indexPath: IndexPath) {
        self._removeKvoForVM()
        self.indexPath = indexPath
        self.rowVM = rowVM
        self.refreshSubviews(isKvo: false)
        self.layoutIfNeeded()
        self._addKvoForVM()
    }
    
    public func refreshSubviews(isKvo:Bool) -> Void {
        
    }
    
    public func keyPathOfKvoForVM() -> Array<String>? {
        return nil
    }
    
    private func _addKvoForVM(){
        if let keyPaths = self.keyPathOfKvoForVM() {
            if let rowVM:AnyObject = self.rowVM as AnyObject? {
                for keyPath in keyPaths {
                    rowVM.addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
                }
            }
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.refreshSubviews(isKvo: true)
        self.layoutIfNeeded()
    }
    
    private func _removeKvoForVM(){
        if let keyPaths = self.keyPathOfKvoForVM() {
            if let rowVM:AnyObject = self.rowVM as AnyObject? {
                for keyPath in keyPaths {
                    rowVM.removeObserver(self, forKeyPath: keyPath, context: nil)
                }
            }
        }
    }

    deinit {
        self._removeKvoForVM()
    }
}
