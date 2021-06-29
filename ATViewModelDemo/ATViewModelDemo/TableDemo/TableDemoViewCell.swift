//
//  TableDemoViewCell.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/29.
//

import UIKit

class TableDemoViewCell: ATTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func refreshSubviews(isKvo: Bool) {
        if let rowVM:TableDemoRowViewModel = self.rowVM as? TableDemoRowViewModel {
            self.textLabel?.text = "\(rowVM.data as? String)  |  rowNum:\(rowVM.rowNum)"
        }
    }
    
    override func keyPathOfKvoForVM() -> Array<String>? {
        return ["rowNum"]
    }
    
}
