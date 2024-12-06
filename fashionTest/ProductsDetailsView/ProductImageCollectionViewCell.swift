//
//  ProductImageCollectionViewCell.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//

import UIKit

class ProductImageCollectionViewCell: UICollectionViewCell, ProductImageRendering {
    var imageURL: String?
    @IBOutlet weak var productImage: UIImageView!
}
