//
//  CollectionDemoViewController.swift
//  ATViewModelDemo
//
//  Created by liyebiao on 2021/6/29.
//

import UIKit

class CollectionDemoItemViewModel: ATCollectionItemViewModel {

    public override func createLayout() {
        self.cellId = "CollecitonDemoCollectionViewCell"
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.width, height: 100)
    }
    
    @objc dynamic var rowNum:Int = 0
    
}

class CollectionDemoViewModel: ATCollectionViewModel {
    
    public func loadData(){
        self.viewProxy.defaultSectionVM?.itemArray.removeAll()
        for i in 1...20 {
            let itemVM = CollectionDemoItemViewModel.init()
            itemVM.data = "Text\(i)"
            itemVM.createLayout()
            itemVM.onDidSelectItemBlock = { (_,itemVM) in
                if let _itemVM = itemVM as? CollectionDemoItemViewModel {
                    _itemVM.rowNum += 1
                    _itemVM.kvoRefreshFlag = true
                }
            }
            self.viewProxy.defaultSectionVM?.itemArray.append(itemVM)
        }
        self.refreshState(state: "didLoadData", msg: nil, data: nil)
    }
    
}

class CollectionDemoViewController: UIViewController, ATStateProtocol,UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel:CollectionDemoViewModel = {
        let vm = CollectionDemoViewModel.init(viewProxy: ATCollectionViewProxy.init(dynamicHandler: self))
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
        self.collectionView.delegate = self.viewModel.viewProxy
        self.collectionView.dataSource = self.viewModel.viewProxy
        self.collectionView.register(CollecitonDemoCollectionViewCell.self, forCellWithReuseIdentifier: "CollecitonDemoCollectionViewCell")
    }
    
    func didChangeState(state: String, msg: String?, data: Any?) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("collectionView willDisplay cell:")
    }

}
