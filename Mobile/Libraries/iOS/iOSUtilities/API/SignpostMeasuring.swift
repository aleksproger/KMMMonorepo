import Foundation
import os.signpost

public func measuring<T>(
	_ name: StaticString = #function,
	_ block: @escaping () -> T
) -> T {
	let signposter = OSSignposter(
        subsystem: Bundle.main.bundleIdentifier ?? "kmm.foundation",
        category: "measure.block"
    )

	let state = signposter.beginInterval(name, id: signposter.makeSignpostID(), "\(String(reflecting: T.self))")

	let store = block()

	signposter.endInterval(name, state, "\(String(reflecting: T.self))")

	return store
}