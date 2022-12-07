import XCTest
@testable import GOONetwork

@available(macOS 12.0, *)
@available(iOS 13.0, *)
final class GOONetworkTests: XCTestCase {

    //Defines a Product struct that conforms to the Decodable protocol, which means it can be initialized from a JSON object.
    //Creates an expectation, which is a way to specify that some operation is expected to happen within a certain time frame.
    //Sets the URL to a valid one that returns a JSON object.
    //Tries to decode the JSON object into a Product instance using the GOONetwork.decodeJSON(fromUrl:) method.
    //If the Product instance is valid, it checks that its title and description properties have the expected values, and then it fulfills the expectation.
    //If the Product instance is not valid, it fails the test with a message indicating that it failed to decode the JSON.
    //If an error occurred while trying to decode the JSON, it also fails the test with a message indicating that it failed to decode the JSON.
    //Waits for the expectation to be fulfilled, and if it isn't fulfilled within 10 seconds, it fails the test with a timeout error.
    func testDecodeJSONWithValidURL() async {
        struct Product: Decodable {
            let title: String
            let description: String
        }

        let expectation = XCTestExpectation(description: "Decode JSON from URL")
        let url = "https://dummyjson.com/products/1"

        do {
            let product: Product? = try await GOONetwork.decodeJSON(fromUrl: url)

            if let product {
                XCTAssertEqual(product.title, "iPhone 9")
                XCTAssertEqual(product.description, "An apple mobile which is nothing like apple")
                expectation.fulfill()
            } else {
                XCTFail("Failed to decode JSON from url \(url)")
            }
        } catch {
            XCTFail("Failed to decode JSON from url \(url)")
        }

        wait(for: [expectation], timeout: 10.0)
    }

    //Here, we're creating a test expectation, setting the URL to an invalid one, and then trying to decode the JSON.
    //If we get a valid Product instance, we fail the test because we expected to fail to decode the JSON. Otherwise, we fulfill the expectation.
    //Finally, we wait for the expectation to be fulfilled.
    func testDecodeJSONWithInvalidURL() async {
        struct Product: Decodable {
            let title: String
            let description: String
        }

        let expectation = XCTestExpectation(description: "Decode JSON from invalid URL")
        let url = "https://dummyjson.com/invalid-url"

        do {
            let product: Product? = try await GOONetwork.decodeJSON(fromUrl: url)

            if product != nil {
                XCTFail("Expected to fail to decode JSON from url \(url)")
            } else {
                expectation.fulfill()
            }
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    //Here, we're doing the same thing as before, but instead of using an invalid URL, we're using a valid URL but expecting the JSON it returns to be invalid.
    //If we get a valid Product instance, we fail the test because we expected to fail to decode the JSON.
    //Otherwise, we fulfill the expectation. Finally, we wait for the expectation to be fulfilled.
    func testDecodeInvalidJSON() async {
        struct Product: Decodable {
            let invalidTitle: String
            let invalidDesc: String
        }

        let expectation = XCTestExpectation(description: "Decode JSON from invalid JSON")
        let url = "https://dummyjson.com/products/1"

        do {
            let product: Product? = try await GOONetwork.decodeJSON(fromUrl: url)

            if product != nil {
                XCTFail("Expected to fail to decode JSON from url \(url)")
            } else {
                expectation.fulfill()
            }
        } catch {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testNetworkError() {
        // Test that the `id` property returns the correct value.
        XCTAssertEqual(NetworkError.urlError.id, NetworkError.urlError)
        XCTAssertEqual(NetworkError.responseError.id, NetworkError.responseError)
        XCTAssertEqual(NetworkError.dataError.id, NetworkError.dataError)
        XCTAssertEqual(NetworkError.decodeError.id, NetworkError.decodeError)
        XCTAssertEqual(NetworkError.unknownError.id, NetworkError.unknownError)

        // Test that the `localizedDescription` property returns the correct value.
        XCTAssertEqual(NetworkError.urlError.localizedDescription, "There was an error with the URL.")
        XCTAssertEqual(NetworkError.responseError.localizedDescription, "There was an error with the server's response.")
        XCTAssertEqual(NetworkError.dataError.localizedDescription, "There was an error with the data returned by the server.")
        XCTAssertEqual(NetworkError.decodeError.localizedDescription, "There was an error decoding the data returned by the server.")
        XCTAssertEqual(NetworkError.unknownError.localizedDescription, "An unknown error occurred.")

        // Test that the `CaseIterable` protocol is implemented correctly.
        XCTAssertEqual(NetworkError.allCases.count, 5)
        XCTAssertTrue(NetworkError.allCases.contains(.urlError))
        XCTAssertTrue(NetworkError.allCases.contains(.responseError))
        XCTAssertTrue(NetworkError.allCases.contains(.dataError))
        XCTAssertTrue(NetworkError.allCases.contains(.decodeError))
        XCTAssertTrue(NetworkError.allCases.contains(.unknownError))
    }
}
