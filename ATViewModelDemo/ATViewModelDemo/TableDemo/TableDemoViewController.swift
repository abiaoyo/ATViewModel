//
//  TableDemoViewController.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/29.
//

import UIKit

class TableDemoRowViewModel: ATTableRowViewModel {
    
    public override func createLayout() {
        self.cellId = "TableDemoViewCell"
    }
    
    @objc dynamic var rowNum:Int = 0
    
}

class TableDemoViewModel: ATTableViewModel {
    
    public func loadData(){
        self.viewProxy.defaultSectionVM?.rowArray.removeAll()
        for i in 1...20 {
            let rowVM = TableDemoRowViewModel.init()
            rowVM.data = "Text\(i)"
            rowVM.createLayout()
            rowVM.onDidSelectRowBlock = { (_,rowVM) in
                if let _rowVM = rowVM as? TableDemoRowViewModel {
                    _rowVM.rowNum += 1
                }
            }
            self.viewProxy.defaultSectionVM?.rowArray.append(rowVM)
        }
        self.refreshState(state: "didLoadData", msg: nil, data: nil)
    }
    
}

class TableDemoViewController: UIViewController, ATStateProtocol, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel:TableDemoViewModel = {
        let vm = TableDemoViewModel.init(viewProxy: ATTableViewProxy.init(dynamicHandler: self))
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
        self.setupSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.loadData()
        }
        
    }
    
    func setupData(){
        
    }
    
    func setupSubviews(){
        self.tableView.delegate = self.viewModel.viewProxy
        self.tableView.dataSource = self.viewModel.viewProxy
        self.tableView.register(UINib.init(nibName: "TableDemoViewCell", bundle: nil), forCellReuseIdentifier: "TableDemoViewCell")
    }
    
    func didChangeState(state: String, msg: String?, data: Any?) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView willDisplay cell:")
    }

}
