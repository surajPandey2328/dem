//
//  ArticleTests.swift
//  ArticleTests
//
//  Created by Sudhir on 10/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import XCTest
@testable import Article

class ArticleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
//Test Cases
    
    func test_UpdateSearchResults_ParsesData() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        XCTAssertEqual(
            sut.searchResults.count,
            0,
            "searchResults should be empty before the data task runs")
        let url =
            URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let dataTask = sut.defaultSession.dataTask(with: url!) {
            data, response, error in
            // if HTTP request is successful, call updateSearchResults(_:)
            // which parses the response data into Tracks
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                self.sut.updateSearchResults(data)
            }
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertEqual(sut.searchResults.count, 3, "Didn't parse 3 items from fake response")
    }
    
    
    func testGameStyleCanBeChanged() {
        // given
        let segmentedControl = UISegmentedControl()
        
        // when
        XCTAssertEqual(
            mockUserDefaults.gameStyleChanged,
            0,
            "gameStyleChanged should be 0 before sendActions")
        segmentedControl.addTarget(sut,
                                   action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
        segmentedControl.sendActions(for: .valueChanged)
        
        // then
        XCTAssertEqual(
            mockUserDefaults.gameStyleChanged,
            1,
            "gameStyle user default wasn't changed")
    }
    
    
    func testScoreIsComputed() {
        // 1. given
        let guess = sut.targetValue + 5
        
        // 2. when
        sut.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    func testScoreIsComputedWhenGuessLTTarget() {
        // 1. given
        let guess = sut.targetValue - 5
        
        // 2. when
        sut.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        // given
        let url =
            URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    func testCallToiTunesCompletes() {
        // given
        let url =
            URL(string: "https://itune.apple.com/search?media=music&entity=song&term=abba")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
}
