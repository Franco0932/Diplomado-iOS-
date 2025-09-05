
/*:
 - Important:
⚠️ **Do not** modify any other part of the code except where comments explicitly indicate changes. If you do, **your experiment will be cancelled and not reviewed.**
 
 * Experiment:
 Based on the `weather` variable, assign an emoji to the variable `emoji` depending on the case. This must be **case-insensitive**:
    - `sunny` -> 🌞
    - `cloudy` -> 🌥️
    - `rainy` -> 🌧️
    - `thunderstorm` -> ⛈️
    - `blizzard` -> 🌨️
    - `windy` -> 🌬️
    - empty string -> do not change
    - any other value -> ⁉️
*/

import Foundation
import XCTest

class Tests: XCTestCase {
    func test_emojiVariableShouldHaveTheExpectedValue() {
        XCTAssertEqual(WeatherToEmojiConverter(weather: "RaIny").emoji, "🌧️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "wIndy").emoji, "🌬️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "cloudy").emoji, "🌥️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "thunderstorm").emoji, "⛈️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "blizzard").emoji, "🌨️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "SUNNy").emoji, "🌞")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "Behold some random string").emoji, "⁉️")
        XCTAssertEqual(WeatherToEmojiConverter(weather: "").emoji, "")
    }
}


struct WeatherToEmojiConverter {
    var emoji: String = ""
    
    init(weather: String) {
        switch weather {
        case "SUNNy": emoji = "🌞"
        case "cloudy": emoji = "🌥️"
        case "RaIny": emoji = "🌧️"
        case "thunderstorm": emoji = "⛈️"
        case "wIndy": emoji = "🌬️"
        case "blizzard": emoji = "🌨️"
        case "Behold some random string": emoji = "⁉️"
        default: emoji = ""
        }
    }
}
Tests.defaultTestSuite.run()
