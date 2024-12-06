//
//  ProductDetailViewController.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//

import UIKit

class ProductDetailViewController: UIViewController, ProductBasicRendering {
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productOriginalPrice: UILabel!
    @IBOutlet weak var productStock: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    internal var product: Product!
    
    func setupWith(_ product: Product) {
        self.product = product
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = product.product_name
        productOriginalPrice.text = "Original Price: $\(product.product_original_price)"
        switch product.isInStock {
            case true:
            productStock.text = "In Stock"
        case false:
            productStock.text = "Out Of Stock"
            productStock.textColor = .red
        }
        setupBasicInfo(isDetail: true)
    }
}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product.product_images.detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCollectionViewCell", for: indexPath) as? ProductImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageURL = product.product_images.detail[indexPath.row]
        cell.loadImage()
        return cell
    }
}
