//
//  ProductRendering.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//
import UIKit

/// CODE SMELL -> RAN OUT OF TIME TO PROPERLY SEPARATE CONCERNS & NAMING

protocol ProductRendering {
    var product: Product! { get }
    func setupWith(_ product: Product)
}

protocol ProductBasicRendering: ProductRendering {
    var brandLabel: UILabel! { get }
    var nameLabel: UILabel! { get }
    var priceLabel: UILabel! { get }
}

protocol ProductImageRendering {
    var productImage: UIImageView! { get }
    var imageURL: String? { get }
}

extension ProductImageRendering {
    func loadImage() {
        if let imageUrl = imageURL {
            NetworkService.shared.loadImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    if let image {
                        self.productImage.image = image
                    }
                }
            }
        }
    }
}

extension ProductBasicRendering {
    func setupBasicInfo(isDetail: Bool = false) {
        brandLabel.text = product.product_brand
        nameLabel.text = product.product_name
        priceLabel.text = "$\(product.product_price)"
    }
}
