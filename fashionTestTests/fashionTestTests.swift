//
//  fashionTestTests.swift
//  fashionTestTests
//
//  Created by Cosmin Cucu on 6/12/24.
//

import XCTest
@testable import fashionTest

final class fashionTestTests: XCTestCase {
    
    override func setUpWithError() throws {
        NetworkService.shared = FakeNetworkService()
        try super.setUpWithError()
    }
    
    func testListingModelCallsNetworkService () {
        let model = ProductsTableViewModel()
        
        let expectation = XCTestExpectation(description: "Products fetch expectation")
        model.fetchProducts(
            expectation.fulfill
        )
        
        wait(for: [expectation])
        XCTAssertEqual(model.products.count, 1)
        let modelProduct = model.products.first
        XCTAssertNotNil(modelProduct)
        XCTAssertEqual(modelProduct, fakeProduct)
    }
}

let fakeProduct = Product(product_id: 1, product_name: "Fake Product", product_images: ProductImages(listing: ["someListing"], detail: ["someURL"], zoom: ["someZoom"], thumb: ["someThumb"]), product_price: 100.0, product_original_price: 200.0, product_brand: "Fakest", product_stock_state: "not_ok")

class FakeNetworkService: NetworkServicing {
    
    
    func fetchProducts(completion: @escaping (Result<[fashionTest.Product], any Error>) -> Void) {
        completion(.success([fakeProduct]))
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
    }
}
