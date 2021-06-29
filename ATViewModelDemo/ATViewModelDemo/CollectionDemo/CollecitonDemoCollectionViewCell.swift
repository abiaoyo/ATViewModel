//
//  CollecitonDemoCollectionViewCell.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/29.
//

import UIKit

class CollecitonDemoCollectionViewCell: ATCollectionViewCell {
    
    lazy var textLabel:UILabel = {
        return UILabel.init()
    }()
    
    override func setupSubviews() {
        self.contentView.addSubview(self.textLabel)
        self.textLabel.frame = CGRect.init(x: 10, y: 20, width: 300, height: 20)
    }
    
    override func refreshSubviews(isKvo: Bool) {
        if let rowVM:CollectionDemoItemViewModel = self.itemVM as? CollectionDemoItemViewModel {
            self.textLabel.text = "\(rowVM.data as? String)  |  rowNum:\(rowVM.rowNum)"
        }
        if self.indexPath!.item % 2 == 0 {
            self.contentView.backgroundColor = UIColor.orange
        }else{
            self.contentView.backgroundColor = UIColor.green
        }
    }
    
    override func keyPathOfKvoForVM() -> Array<String>? {
        return ["kvoRefreshFlag"]
    }
}
