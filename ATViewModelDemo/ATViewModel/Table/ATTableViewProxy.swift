//
//  ATTableViewProxy.swift
//  ATViewModelDemo
//
//  Created by liyebiao
//

import UIKit

public class ATTableViewProxy: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    private var _defaultSectionVM:ATTableSectionProtocol? = nil
    public var defaultSectionVM:ATTableSectionViewModel? {
        get {
            if _defaultSectionVM == nil{
                _defaultSectionVM = ATTableSectionViewModel.init()
            }
            return _defaultSectionVM as? ATTableSectionViewModel
        }
    }
    public lazy var sectionVMs:Array<ATTableSectionViewModel> = {
        return Array<ATTableSectionViewModel>.init()
    }()
    
    weak var dynamicHandler:AnyObject?
    
    //MARK: - init
    init(dynamicHandler:AnyObject) {
        self.dynamicHandler = dynamicHandler
    }
    
    public override init() {
        
    }
    
    //MARK: - Private
    private func getSectionVM(section:Int) -> ATTableSectionProtocol{
        var sectionVM:ATTableSectionProtocol? = nil
        if _defaultSectionVM != nil{
            sectionVM = _defaultSectionVM
        }else{
            sectionVM = self.sectionVMs[section]
        }
        return sectionVM!
    }
    
    private func getRowVM(indexPath:IndexPath) -> ATTableRowProtocol{
        let sectionVM = self.getSectionVM(section: indexPath.section)
        return sectionVM.rowArray[indexPath.row]
    }
    
    //MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        if _defaultSectionVM != nil{
            return 1
        }
        return self.sectionVMs.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.rowArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowVM = self.getRowVM(indexPath: indexPath)
        
        let cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: rowVM.cellId, for: indexPath)
        if let _ = cell {
            if let _cell:ATTableCellProtocol = cell as? ATTableCellProtocol {
                _cell.configVM(rowVM: rowVM, indexPath: indexPath)
            }
            return cell!
        }else{
            return UITableViewCell.init()
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section: section)
        return sectionVM.footerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionVM = self.getSectionVM(section: indexPath.section)
        let rowVM:ATTableRowProtocol = sectionVM.rowArray[indexPath.row]
        return rowVM.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionVM = self.getSectionVM(section: section)
        if let headerId:String = sectionVM.headerId {
            if let header:UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) {
                if let _header:ATTableHeaderFooterProtocol = header as? ATTableHeaderFooterProtocol {
                    _header.configVM(sectionVM: sectionVM, section: section)
                }
                return header
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionVM = self.getSectionVM(section: section)
        if let footerId:String = sectionVM.footerId {
            if let footer:UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) {
                if let _footer:ATTableHeaderFooterProtocol = footer as? ATTableHeaderFooterProtocol {
                    _footer.configVM(sectionVM: sectionVM, section: section)
                }
                return footer
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowVM = self.getRowVM(indexPath: indexPath)
        if rowVM.deselectRowAfterDidSelect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if rowVM.onDidSelectRowBlock != nil {
            rowVM.onDidSelectRowBlock!(indexPath,rowVM)
        }else{
            self.dynamicHandler?.tableView?(tableView, didSelectRowAt: indexPath)
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
