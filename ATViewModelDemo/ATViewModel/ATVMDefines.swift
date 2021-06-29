//
//  ATVMDefines.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/29.
//

import UIKit

public typealias ATTableRowDidSelectBlock = (_ indexPath:IndexPath,_ rowVM:ATTableRowProtocol?) -> Void
public typealias ATTableSectionDidSelectBlock = (_ section:Int,_ sectionVM:ATTableSectionProtocol?) -> Void

public typealias ATCollectionItemDidSelectBlock = (_ indexPath:IndexPath,_ itemVM:ATCollectionItemProtocol?) -> Void
public typealias ATCollectionSectionDidSelectBlock = (_ section:Int,_ sectionVM:ATCollectionSectionProtocol?) -> Void

public protocol ATViewModelProtocol {
    var data:Any? {get set}
    func createLayout()
}

public protocol ATViewProtocol {
    func configVM(vm:ATViewModelProtocol) -> Void
}

public protocol ATTableRowProtocol : ATViewModelProtocol{
    var cellId:String {get set}
    var rowHeight:CGFloat {get set}
    var selectionStyle:UITableViewCell.SelectionStyle {get set}
    var onDidSelectRowBlock:ATTableRowDidSelectBlock? {get set}
    var deselectRowAfterDidSelect:Bool {get set}
    //kvo刷新cell标志
    dynamic var kvoRefreshFlag:Any? {get set}
}

public protocol ATTableSectionProtocol : ATViewModelProtocol {
    var rowArray:Array<ATTableRowProtocol> {get set}
    var headerId:String? {get set}
    var footerId:String? {get set}
    var headerHeight:CGFloat {get set}
    var footerHeight:CGFloat {get set}
}

public protocol ATTableCellProtocol {
    var indexPath:IndexPath? {get set}
    var rowVM:ATTableRowProtocol? {get set}
    func configVM(rowVM:ATTableRowProtocol, indexPath:IndexPath) -> Void
}

public protocol ATTableHeaderFooterProtocol {
    var section:Int {get set}
    var sectionVM:ATTableSectionProtocol? {get set}
    func configVM(sectionVM:ATTableSectionProtocol, section:Int) -> Void
}

public protocol ATCollectionItemProtocol : ATViewModelProtocol {
    var cellId:String {get set}
    var itemSize:CGSize {get set}
    var onDidSelectItemBlock:ATCollectionItemDidSelectBlock? {get set}
    //kvo刷新cell标志
    dynamic var kvoRefreshFlag:Any? {get set}
}

public protocol ATCollectionSectionProtocol : ATViewModelProtocol {
    var itemArray:Array<ATCollectionItemProtocol> {get set}
    var sectionInsets:UIEdgeInsets {get set}
    var minimumLineSpacing:CGFloat {get set}
    var minimumInteritemSpacing:CGFloat {get set}
    var headerId:String? {get set}
    var footerId:String? {get set}
    var headerSize:CGSize {get set}
    var footerSize:CGSize {get set}
}

public protocol ATCollectionCellProtocol {
    var indexPath:IndexPath? {get set}
    var itemVM:ATCollectionItemProtocol? {get set}
    func configVM(itemVM:ATCollectionItemProtocol, indexPath:IndexPath) -> Void
}

public protocol ATCollectionReuseableViewProtocol {
    var indexPath:IndexPath? {get set}
    var sectionVM:ATCollectionSectionProtocol? {get set}
    func configVM(sectionVM:ATCollectionSectionProtocol, indexPath:IndexPath) -> Void
}






public protocol ATStateProtocol : NSObjectProtocol{
    func didChangeState(state:String,msg:String?,data:Any?)
}
