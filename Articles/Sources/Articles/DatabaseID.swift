//
//  DatabaseID.swift
//  NetNewsWire
//
//  Created by Brent Simmons on 7/15/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation
import RSCore

// MD5 works because:
// * It’s fast
// * Collisions aren’t going to happen with feed data

private var databaseIDCache = [String: String]()
private var databaseIDCacheLock = NSLock()
public func databaseIDWithString(_ s: String) -> String {
    databaseIDCacheLock.lock()
    defer {
        databaseIDCacheLock.unlock()
    }
	
	if let identifier = databaseIDCache[s] {
		return identifier
	}
	
	let identifier = s.md5String
	databaseIDCache[s] = identifier
	return identifier
}

// old, unsafe version - left here only for the purposes of running the benchmark comparison.
private var _oldLock = os_unfair_lock_s()
public func _databaseIDWithString(_ s: String) -> String {
    os_unfair_lock_lock(&_oldLock)
    defer {
           os_unfair_lock_unlock(&_oldLock)
    }

    if let identifier = databaseIDCache[s] {
        return identifier
    }
    
    let identifier = s.md5String
    databaseIDCache[s] = identifier
    return identifier
}
