
import CollectionsBenchmark
import Articles
import Foundation

// Create a new benchmark instance.
var benchmark = Benchmark(title: "Article Database ID")

benchmark.registerInputGenerator(for: String.self) { size in
    return "\(size)"
}

//benchmark.addSimple(
//  title: "NSLock DatabaseIdWithString",
//  input: String.self
//) { input in
//  blackHole(
//    databaseIDWithString(input)
//  )
//}
//
//benchmark.addSimple(
//  title: "os_unfair_lock DatabaseIdWithString",
//  input: String.self
//) { input in
//  blackHole(
//    _databaseIDWithString(input)
//  )
//}

var _oldLock = os_unfair_lock_s()
let _newLock = NSLock()
func unfairlock() {
    os_unfair_lock_lock(&_oldLock)
    os_unfair_lock_unlock(&_oldLock)
}
func nslock() {
    _newLock.lock()
    _newLock.unlock()
}

benchmark.addSimple(
  title: "only os_unfair_lock",
  input: String.self
) { input in
  blackHole(
    unfairlock()
  )
}

benchmark.addSimple(
  title: "only nslock",
  input: String.self
) { input in
  blackHole(
    nslock()
  )
}

// Execute the benchmark tool with the above definitions.
benchmark.main()
