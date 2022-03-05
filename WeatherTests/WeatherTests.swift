//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by 118 on 2022/3/5.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    func testApiKey() {
        XCTAssertTrue(Constants.API.Key == "e887e6e863e03c3868e2c96a90db90be")
    }
    
    func testWeatherList() {
        let expectation = self.expectation(description: "Wait to load weather list")
        let params = mockParameters()
        let endpoint = APIEndPoint(path: .onecall, method: .get, parameters: params)
        
        var list: WeatherList?
        
        let service = WeatherService(endPoint: endpoint)
        service.updateList { weatherList in
            print("mapped Successfully")
            list = weatherList
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: Constants.API.kTimeOutInterval, handler: nil)
        XCTAssertNotNil(list)
    }
    
    
    // MARK: - Helpers
    func mockParameters() -> [String:String] {
        let params = [
            "lat":"25.191116",
            "lon":"55.272355",
            "appid": Constants.API.Key
        ]
        
        return params
    }
}
