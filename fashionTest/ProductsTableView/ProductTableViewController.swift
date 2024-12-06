//
//  ViewController.swift
//  fashionTest
//"
//  Created by Cosmin Cucu on 6/12/24.
//

import UIKit

class ProductTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ProductsTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.setupFor(tableView: tableView)
        viewModel.fetchProducts()
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? ProductDetailViewController, let product = sender as? Product {
            destination.setupWith(product)
        }
    }
}

extension ProductTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "presentDetail", sender: viewModel.products[indexPath.row])
    }
}
