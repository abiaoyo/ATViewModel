//
//  ATViewModel.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/28.
//

import UIKit

public typealias ATTableRowDidSelectBlock = (indexPath:NSIndexPath,viewModel:Any?)

public protocol ATTableRowProtocol {
    func cellId() -> String
    func rowHeight() -> Float
    func selectionStyle() -> UITableViewCell.SelectionStyle
    func createLayout()
    func onDidSelectRowBlock() -> ATTableRowDidSelectBlock?
}

extension ATTableRowProtocol{
    func selectionStyle() -> UITableViewCell.SelectionStyle{
        return .none
    }
    func createLayout() {
        
    }
}

public typealias ATTableSectionDidSelectBlock = (section:Int,viewModel:Any?)

public protocol ATTableSectionProtocol {
    func rowArray() -> Array<ATTableRowProtocol>
    func headerId() -> String?
    func footerId() -> String?
    func headerHeight() -> Float
    func footerHeight() -> Float
    func createLayout()
    func onDidSelectSectionHeaderBlock() -> ATTableSectionDidSelectBlock?
    func onDidSelectSectionFooterBlock() -> ATTableSectionDidSelectBlock?
}

extension ATTableSectionProtocol {
    func headerHeight() -> Float{
        return 0
    }
    func footerHeight() -> Float{
        return 0
    }
    func createLayout() {
        
    }
}





//typedef void (^GVBsDidSelectRowBlock)(NSIndexPath * indexPath, id cellData);
//
//@protocol GVBsTableRowProtocol <NSObject>
//@required
//- (NSString *)cellIdentifier;
//- (CGFloat)cellRowHeight;
//@optional
//- (UITableViewCellSelectionStyle)selectionStyle;
//- (void)createLayout;
//- (GVBsDidSelectRowBlock)onDidSelectRowBlock;
//@end
//
//
//typedef void (^GVBsClickSectionBlock)(NSUInteger section, id sectionData);
//@protocol GVBsTableSectionProtocol <NSObject>
//@required
//- (NSMutableArray<GVBsTableRowProtocol> *)rowArray;
//@optional
//- (NSString *)headerIdentifier;
//- (NSString *)footerIdentifier;
//- (CGFloat)headerHeight;
//- (CGFloat)footerHeight;
//- (NSString *)headerTitle;
//- (NSString *)footerTitle;
//- (void)createLayout;
//- (GVBsClickSectionBlock)onClickSectionBlock;
//@end
//
//@protocol GVBsTableCellProtocol <NSObject>
//@required
//@property (nonatomic,strong) id cellData;
//- (void)setCellData:(id<GVBsTableRowProtocol>)cellData
//          indexPath:(NSIndexPath *)indexPath;
//@optional
//@property (nonatomic,weak) id eventHandler;
//@end
//
//@protocol GVBsTableSectionHeaderFooterProtocol <NSObject>
//@optional
//@property (nonatomic,weak) id eventHandler;
//- (void)setSectionModel:(id<GVBsTableSectionProtocol>)sectionModel
//                section:(NSUInteger)section;
//@end
//
//
//
//
//
//@protocol GVBsCollectionItemProtocol <NSObject>
//@required
//- (NSString *)cellIdentifier;
//- (CGSize)cellItemSize;
//@optional
//- (id)rowData;
//- (void)createLayout;
//- (NSIndexPath *)indexPath;
//- (GVBsDidSelectRowBlock)onDidSelectRowBlock;
//@end
//
//@protocol GVBsCollectionSectionProtocol <NSObject>
//@required
//- (NSMutableArray<GVBsCollectionItemProtocol> *)itemArray;
//@optional
//- (id)customObject;  //用户自定义对象，主要用于携带数据，跟界面无关
//
//- (UIEdgeInsets)sectionInset;
//- (CGFloat)minimumLineSpacing;
//- (CGFloat)minimumInteritemSpacing;
//- (NSString *)headerIdentifier;
//- (NSString *)footerIdentifier;
//- (CGSize)headerSize;
//- (CGSize)footerSize;
//- (void)createLayout;
//- (GVBsClickSectionBlock)onClickSectionBlock;
//@end
//
//@protocol GVBsCollectionCellProtocol <NSObject>
//@required
//- (void)setCellData:(id)cellData
//          indexPath:(NSIndexPath *)indexPath;
//@optional
//@property (nonatomic,weak) id eventHandler;
//@end
//
//@protocol GVBsCollectionReusableViewProtocol <NSObject>
//@optional
//@property (nonatomic,weak) id eventHandler;
//- (void)setSectionModel:(id<GVBsCollectionSectionProtocol>)sectionModel
//              indexPath:(NSIndexPath *)indexPath;
//@end
