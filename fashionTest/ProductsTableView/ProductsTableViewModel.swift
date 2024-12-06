//
//  ProductsTableViewModel.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//

import UIKit

class ProductsTableViewModel: NSObject, UITableViewDataSource {
    private(set) var products: [Product] = []
    private weak var tableView: UITableView?
    
    override init() {
        super.init()
    }
    
    func setupFor(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
    }
    
    func fetchProducts(_ completion: (() -> Void)? = nil) {
        NetworkService.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.tableView?.reloadData()
                case .failure(let error):
                    print("Error fetching products: \(error.localizedDescription)")
                }
                completion?()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupWith(products[indexPath.row])
        return cell
    }
}
