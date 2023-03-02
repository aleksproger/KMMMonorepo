import Foundation

public typealias MainThreadRunner = (@escaping () -> Void) -> Void

public func onMainThread(_ block: @escaping () -> Void) {
	if Thread.isMainThread {
		block()
	} else {
		DispatchQueue.main.async(execute: block)
	}
}

public func onMainThreadAsync(_ block: @escaping () -> Void) {
	DispatchQueue.main.async(execute: block)
}

public func onMainThread<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
	{ arg in onMainThread { closure(arg) } }
}

public func syncOnMainThread(_ block: @escaping () -> Void) {
	if Thread.isMainThread {
		block()
	} else {
		DispatchQueue.main.sync(execute: block)
	}
}