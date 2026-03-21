import XCTest
@testable import eco_buddy_ios

final class AppErrorTests: XCTestCase {
    func testServerMessageUsesMappedText() {
        XCTAssertEqual(
            AppError.serverMessage(.verifyEmail).message,
            "Please verify your email"
        )
    }

    func testAPIErrorMessageIncludesMethodEndpointAndResponse() {
        let error = APIError(
            endpoint: "/v1/example",
            httpMethod: "GET",
            response: "Bad Request",
            error: nil
        )

        XCTAssertEqual(
            AppError.apiError(error).message,
            "Error occurred while calling endpoint: GET /v1/example\nBad Request"
        )
    }
}
