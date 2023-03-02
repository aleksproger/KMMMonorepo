//
//  Created by Kotov Max on 20.07.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public final class AtomicArray<T> {
	private var _value = [T]()

	private let queue = DispatchQueue(
		label: "com.xcodegen.atomic",
		attributes: .concurrent,
		autoreleaseFrequency: .inherit,
		target: .global()
	)

	public init() {}

	public var value: [T] {
		queue.sync { _value }
	}

	public func append(_ element: T) {
		queue.async(flags: .barrier) { [weak self] in
			self?._value.append(element)
		}
	}
}
