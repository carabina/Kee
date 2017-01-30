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

import Foundation
import KeychainAccess

public final class KeyValueKeychainStorage: KeyValueStorage {
    
    private let keychain: Keychain
    
    public init(service: String, accessibility: Accessibility = .afterFirstUnlock) {
        
        keychain = Keychain(service: service).accessibility(accessibility)
    }
    
    // MARK: - KeyValueStorage
    
    public func setValue(_ value: Any?, forKey key: String) throws {
        
        if let value = value {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            try keychain.set(data, key: key)
            
        } else {
            try keychain.remove(key)
        }
    }
    
    public func getValue<T>(forKey key: String) throws -> T? {
        
        guard let data = try keychain.getData(key)
            else { return nil }
        guard let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? T
            else { throw KeyValueStorageError.type(reason: "Cannot convert unarchived object to given type: \(T.self)") }
        
        return value
    }
    
    public func removeAllKeys() throws {

        try keychain.removeAll()
    }
}
