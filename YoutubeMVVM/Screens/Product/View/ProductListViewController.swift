//
//  ProductListViewController.swift
//  YoutubeMVVM
//
//  Created by Sarath P on 09/02/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

}


extension ProductListViewController {
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        productTableView.dataSource = self
        initViewModel()
        observeViewModel()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeViewModel() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stopped Loading")
            case .dataLoaded:
                DispatchQueue.main.async {
                    //UI Changes should be in Main
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error as Any)
            }
        }
    }
}



extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
