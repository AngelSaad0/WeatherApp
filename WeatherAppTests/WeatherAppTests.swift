//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Engy on 8/26/24.
//

import XCTest
@testable import WeatherApp
final class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFechData() throws {
        let expectaion = expectation(description: "Network")
        let url = "https://api.weatherapi.com/v1/forecast.json?key=cde657024d7d4f2c967131756242208&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no"
        WeatherService.fetchWeather(for: url) { weather in
            XCTAssertEqual(weather?.forecast.forecastday[0].hour.count, 24)
            expectaion.fulfill()
        }

        waitForExpectations(timeout: 5)

    }
    func testInvalid() throws {
        let expectaion = expectation(description: "Network")
        WeatherService.fetchWeather(for: " ") { result in
            XCTAssertNil(result)
            expectaion.fulfill()
        }

        waitForExpectations(timeout: 5)

    }

    func testPerformanceExample() throws {
        measure {
        }
    }

}
