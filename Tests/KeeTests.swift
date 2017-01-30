//
//    Copyright (c) 2017 Max Sokolov https://twitter.com/max_sokolov
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import XCTest
@testable import Kee

struct User {
    
    let username: String
}

extension User: KeyValueRepresentable {
    
    var keyValueRepresentation: KeyValueRepresentation {
        return [
            "username": username
        ]
    }
    
    init(keyValueRepresentation rep: KeyValueRepresentation) throws {
        
        username = rep["username"] as? String ?? ""
    }
}

class KeeTests: XCTestCase {

    func testKeyValueDefaultsStorageCorrectlySetAndGetValues() {
        
        let storage = KeyValueDefaultsStorage()
        
        let setDoubleValue: Double = 42.0
        
        try? storage.setValue(setDoubleValue, forKey: "doubleValue")
        
        let getDoubleValue: Double? = try! storage.getValue(forKey: "doubleValue")
        
        XCTAssertNotNil(getDoubleValue)
        XCTAssertTrue(setDoubleValue == getDoubleValue)
    }
    
    func testKeyValueDefaultsStorageCorrectlySetAndGetObjects() {
        
        let storage = KeyValueDefaultsStorage()
        
        let user = User(username: "Test")
        
        try? storage.setObject(user, forKey: "user")
        
        let storedUser: User? = try! storage.getObject(forKey: "user")
        
        XCTAssertNotNil(storedUser)
        XCTAssertTrue(storedUser?.username == user.username)
    }
}
