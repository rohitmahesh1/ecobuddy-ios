import XCTest
@testable import eco_buddy_ios

final class StringExtensionTests: XCTestCase {
    func testThumbnailURLBuildsHTTPSYouTubeThumbnailURL() {
        XCTAssertEqual(
            "abc123".thumbnailURL,
            "https://img.youtube.com/vi/abc123/0.jpg"
        )
    }
}
