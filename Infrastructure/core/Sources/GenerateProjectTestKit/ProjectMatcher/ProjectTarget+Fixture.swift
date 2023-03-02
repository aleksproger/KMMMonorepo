//
//  Copyright © 2022 Sberbank. All rights reserved.
//

extension ProjectTarget {
	public static func application(
		name: String = "ExampleApp",
		dependencies: [String] = []
	) -> ProjectTarget {
		ProjectTarget(
			name: name,
			sources: ["\(name).swift"],
			dependencies: dependencies,
			productType: .application
		)
	}

	public static func framework(
		name: String = "ExampleFramework",
		dependencies: [String] = []
	) -> ProjectTarget {
		ProjectTarget(
			name: name,
			sources: ["\(name).swift"],
			dependencies: dependencies,
			productType: .framework
		)
	}
}
