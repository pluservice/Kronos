import XCTest
@testable import Kronos

final class BootDetectorTests: XCTestCase {

    func testGetUnsetBootVolatileFlag() {
        let rnd1 = String(UUID().hashValue)
        let found1 = BootDetector.getBootVolatileFlag(rnd1)
        XCTAssertFalse(found1)
    }

    func testSetBoolVolatileFlag() {
        let rnd1 = String(UUID().hashValue)
        let rnd2 = String(UUID().hashValue)

        let found1 = BootDetector.getBootVolatileFlag(rnd1)
        XCTAssertFalse(found1)

        let found2 = BootDetector.getBootVolatileFlag(rnd2)
        XCTAssertFalse(found2)

        BootDetector.setBootVolatileFlag(rnd1)

        let found3 = BootDetector.getBootVolatileFlag(rnd1)
        XCTAssertTrue(found3)

        let found4 = BootDetector.getBootVolatileFlag(rnd2)
        XCTAssertFalse(found4)
    }

    func testGetSetBootVolatileFlag() {
        let rnd1 = String(UUID().hashValue)
        BootDetector.setBootVolatileFlag(rnd1)

        let found1 = BootDetector.getBootVolatileFlag(rnd1)
        XCTAssertTrue(found1)
    }
}
