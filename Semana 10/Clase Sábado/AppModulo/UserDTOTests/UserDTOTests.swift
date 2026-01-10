//
//  UserDTOTests.swift
//  UserDTOTests
//
//  Created by Franco Ruiz on 29/11/25.
//

import XCTest
@testable import AppModulo

final class UserDTOTests: XCTestCase {
    func testUserDecoder() throws{
        let repository = UserLocalRepository()
        let user = try repository.getUsers(by: "")
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.count, 1)
        XCTAssertEqual(user?.first?.address.latitude, "-48.9509")
    }

}
