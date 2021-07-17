//
//  ATCollectionViewProxy.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATCollectionViewProxy: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private var _defaultSectionVM:ATCollectionSectionProtocol? = nil
    public var defaultSectionVM:ATCollectionSectionViewModel? {
        get {
            if _defaultSectionVM == nil{
                _defaultSectionVM = ATCollectionSectionViewModel.init()
            }
            return _defaultSectionVM as? ATCollectionSectionViewModel
        }
    }
    public lazy var sectionVMs:Array<ATCollectionSectionViewModel> = {
        return Array<ATCollectionSectionViewModel>.init()
    }()
    
    weak var dynamicHandler:AnyObject?
    
    //MARK: - init
    init(dynamicHandler:AnyObject?) {
        self.dynamicHandler = dynamicHandler
    }
    
    public override init() {
        
    }
    
    //MARK: - Private
    private func getSectionVM(section:Int) -> ATCollectionSectionProtocol{
        var sectionVM:ATCollectionSectionProtocol? = nil
        if _defaultSectionVM != nil{
            sectionVM = _defaultSectionVM
        }else{
            sectionVM = self.sectionVMs[section]
        }
        return sectionVM!
    }
    
    private func getItemVM(indexPath:IndexPath) -> ATCollectionItemProtocol{
        let sectionVM = self.getSectionVM(section: indexPath.section)
        return sectionVM.itemArray[indexPath.row]
    }
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _defaultSectionVM != nil{
            return 1
        }
        return self.sectionVMs.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.itemArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemVM = self.getItemVM(indexPath: indexPath)
        
        let cell:UICollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: itemVM.cellId, for: indexPath)
        if let _ = cell {
            if let _cell:ATCollectionCellProtocol = cell as? ATCollectionCellProtocol {
                _cell.configVM(itemVM: itemVM, indexPath: indexPath)
            }
            return cell!
        }else{
            return UICollectionViewCell.init()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionVM = self.getSectionVM(section: indexPath.section)
        if kind ==  UICollectionView.elementKindSectionHeader {
            if let headerId:String = sectionVM.headerId {
                let header:UICollectionReusableView? = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
                if header != nil {
                    if let _header:ATCollectionReuseableViewProtocol = header as? ATCollectionReuseableViewProtocol {
                        _header.configVM(sectionVM: sectionVM, indexPath: indexPath)
                    }
                    return header!
                }
            }
        }else if kind ==  UICollectionView.elementKindSectionFooter {
            if let footerId:String = sectionVM.footerId {
                let footer:UICollectionReusableView? = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId, for: indexPath)
                if let _ = footer {
                    if let _footer:ATCollectionReuseableViewProtocol = footer as? ATCollectionReuseableViewProtocol {
                        _footer.configVM(sectionVM: sectionVM, indexPath: indexPath)
                    }
                    return footer!
                }
            }
        }
        return UICollectionReusableView.init()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemVM = self.getItemVM(indexPath: indexPath)
        return itemVM.itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.sectionInsets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.headerSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.footerSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemVM = self.getItemVM(indexPath: indexPath)
        if itemVM.onDidSelectItemBlock != nil {
            itemVM.onDidSelectItemBlock!(indexPath,itemVM)
        }else{
            self.dynamicHandler?.collectionView?(collectionView, didSelectItemAt: indexPath)
        }
    }
    
    //MARK: - 转发
    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if self.dynamicHandler != nil && self.dynamicHandler!.responds(to: aSelector) {
            return self.dynamicHandler
        }
        return super.forwardingTarget(for: aSelector)
    }
    
    public override func responds(to aSelector: Selector!) -> Bool {
        return super.responds(to: aSelector) || (self.dynamicHandler != nil && self.dynamicHandler!.responds(to: aSelector))
    }


}
