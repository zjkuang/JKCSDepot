import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(JKCSDepotTests.allTests),
    ]
}
#endif
