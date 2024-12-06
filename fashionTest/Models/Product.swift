//
//  Product.swift
//  fashionTest
//
//  Created by Cosmin Cucu on 6/12/24.
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Equatable {
    let product_id: Int
    let product_name: String
    let product_images : ProductImages
    let product_price: Double
    let product_original_price: Double
    let product_brand: String
    let product_stock_state: String
}

extension Product {
    var isInStock: Bool {
        return product_stock_state == "ok"
    }
}

struct ProductImages: Codable, Equatable {
    let listing: [String]
    let detail: [String]
    let zoom: [String]
    let thumb: [String]
}
