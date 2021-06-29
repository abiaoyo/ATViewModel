//
//  ViewController.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/28.
//

import UIKit

class VCDemoViewModel: ATViewModel {
    
    private var num:Int = 0
    
    var text:String {
        get {
            return "\(num)"
        }
    }
    
    func change(){
        self.num += 1
        self.refreshState(state: "didChange", msg: nil, data: nil)
    }
    
    func loadData(){
        self.refreshState(state: "didLoadData", msg: nil, data: nil)
    }
    
}

class ViewController: UIViewController, ATStateProtocol {
    
    

    var viewModel:VCDemoViewModel = VCDemoViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.loadData()
        }
    }
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func clickChangeText(_ sender: Any) {
        self.viewModel.change()
    }
    
    
    @IBAction func clickTableDemo(_ sender: Any) {
        let viewCtl = TableDemoViewController.init()
        self.navigationController?.pushViewController(viewCtl, animated: true)
    }
    
    @IBAction func clickCollectionDemo(_ sender: Any) {
        let viewCtl = CollectionDemoViewController.init()
        self.navigationController?.pushViewController(viewCtl, animated: true)
    }
    
    func didChangeState(state: String, msg: String?, data: Any?) {
        self.textLabel.text = self.viewModel.text
    }
    
}

