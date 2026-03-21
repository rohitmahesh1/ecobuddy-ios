import XCTest
@testable import eco_buddy_ios

final class URLExtensionTests: XCTestCase {
    func testExtractVideoIDReturnsVideoIDFromVQueryItem() {
        let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!

        XCTAssertEqual(url.extractVideoID(), "dQw4w9WgXcQ")
    }

    func testExtractVideoIDReturnsNilWhenVQueryItemIsMissing() {
        let url = URL(string: "https://www.youtube.com/watch?list=PL123")!

        XCTAssertNil(url.extractVideoID())
    }
}
