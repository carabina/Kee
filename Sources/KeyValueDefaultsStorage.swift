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

public final class KeyValueDefaultsStorage: KeyValueStorage {
    
    private let defaults: UserDefaults
    private let suiteName: String?
    
    public init(suiteName: String? = nil) {
        
        self.suiteName = suiteName
        if let suiteName = suiteName {
            defaults = UserDefaults(suiteName: suiteName)!
        } else {
            defaults = UserDefaults.standard
        }
    }
    
    // MARK: - KeyValueStorage
    
    public func set(value: Any?, forKey key: String) throws {
        
        if let value = value {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            defaults.set(data, forKey: key)
    
        } else {
            defaults.removeObject(forKey: key)
        }
        
        defaults.synchronize()
    }
    
    public func value<T>(forKey key: String) throws -> T? {
        
        guard let data = defaults.object(forKey: key) as? Data else { return nil }
        
        guard let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? T
            else { throw KeyValueStorageError.type(reason: "Cannot convert unarchived object to given type: \(T.self)") }
        
        return value
    }
    
    public func removeAllKeys() throws {
        
        if let suiteName = suiteName {
            defaults.removeSuite(named: suiteName)
        } else {
            for key in Array(defaults.dictionaryRepresentation().keys) {
                defaults.removeObject(forKey: key)
            }
        }
        
        defaults.synchronize()
    }
}
