//
//  EpistolaireUITests.swift
//  EpistolaireUITests
//
//  Created by Olivier Conan on 23/09/2024.
//

import XCTest

final class EpistolaireUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

}
