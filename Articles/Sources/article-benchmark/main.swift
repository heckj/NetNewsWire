
import CollectionsBenchmark
import Articles
//import Foundation

// Create a new benchmark instance.
var benchmark = Benchmark(title: "Article Database ID")

benchmark.registerInputGenerator(for: String.self) { size in
    return "\(size)" // \(UUID().uuidString) -
}

// Define a very simple benchmark called `kalimbaOrdered`.
benchmark.addSimple(
  title: "NSLock DatabaseIdWithString",
  input: String.self
) { input in
  blackHole(
    databaseIDWithString(input)
  )
}

benchmark.addSimple(
  title: "os_unfair_lock DatabaseIdWithString",
  input: String.self
) { input in
  blackHole(
    _databaseIDWithString(input)
  )
}

// Execute the benchmark tool with the above definitions.
benchmark.main()
