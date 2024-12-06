//
//  ProductTableViewCell.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//
import UIKit

class ProductTableViewCell: UITableViewCell, ProductBasicRendering, ProductImageRendering {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    private(set) var product: Product!
    var imageURL: String?
    
    func setupWith(_ product: Product) {
        self.product = product
        self.imageURL = product.product_images.listing.first
        setupBasicInfo()
        loadImage()
    }
}
