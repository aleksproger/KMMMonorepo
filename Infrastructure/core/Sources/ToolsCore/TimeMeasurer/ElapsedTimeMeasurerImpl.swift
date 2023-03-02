//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public final class ElapsedTimeMeasurerImpl: ElapsedTimeMeasurer {
	private let processInfo: ProcessInfo
	private let digitsAfterDecimal: Int

	public init(
		processInfo: ProcessInfo = .processInfo,
		digitsAfterDecimal: Int = 3
	) {
		self.processInfo = processInfo
		self.digitsAfterDecimal = digitsAfterDecimal
	}

	public func measure(_ block: () throws -> Void) rethrows -> TimeInterval {
		let begin = processInfo.systemUptime
		try block()
		return (processInfo.systemUptime - begin).rounded(toPlaces: digitsAfterDecimal)
	}

	public func measure(_ block: () async throws -> Void) async rethrows -> TimeInterval {
		let begin = processInfo.systemUptime
		try await block()
		return (processInfo.systemUptime - begin).rounded(toPlaces: digitsAfterDecimal)
	}
}

extension Double {
	fileprivate func rounded(toPlaces places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
