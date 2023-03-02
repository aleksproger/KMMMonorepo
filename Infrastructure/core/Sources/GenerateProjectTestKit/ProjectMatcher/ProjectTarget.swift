//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import XcodeProj

public struct ProjectTarget: Equatable {
	public let name: String
	public let sources: [String]
	public let dependencies: [String]
	public let productType: PBXProductType?

	public init(
		name: String,
		sources: [String],
		dependencies: [String],
		productType: PBXProductType?
	) {
		self.name = name
		self.sources = sources
		self.dependencies = dependencies
		self.productType = productType
	}
}
