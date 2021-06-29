//
//  ATCollectionViewCell.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATCollectionViewCell: UICollectionViewCell, ATCollectionCellProtocol{

    public var itemVM: ATCollectionItemProtocol?
    public var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    public func configVM(itemVM: ATCollectionItemProtocol, indexPath: IndexPath) {
        self._removeKvoForVM()
        self.indexPath = indexPath
        self.itemVM = itemVM
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
            if let rowVM:AnyObject = self.itemVM as AnyObject? {
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
            if let rowVM:AnyObject = self.itemVM as AnyObject? {
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
