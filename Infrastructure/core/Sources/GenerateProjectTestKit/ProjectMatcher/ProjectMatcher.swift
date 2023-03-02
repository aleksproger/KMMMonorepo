//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import XcodeProj
import XCTest

public struct ProjectMatcher {
	private let expectedName: String
	private let expectedTargets: [ProjectTarget]

	public init(
		expectedName: String,
		expectedTargets: [ProjectTarget]
	) {
		self.expectedName = expectedName
		self.expectedTargets = expectedTargets
	}

	public func match(
		_ project: XcodeProj,
		_ file: StaticString = #file,
		_ line: UInt = #line
	) throws {
		guard let project = project.pbxproj.rootObject else {
			return XCTFail(
				"Unable to get targets from the project",
				file: file,
				line: line
			)
		}

		let actualTargets = try project.targets.map { target -> ProjectTarget in
			let sourceFiles = try target
				.sourceFiles()
				.compactMap(\.path)
				.sorted()
			let dependencies = target.dependencies
				.compactMap(\.target?.name)
				.sorted()

			return ProjectTarget(
				name: target.name,
				sources: sourceFiles,
				dependencies: dependencies,
				productType: target.productType
			)
		}

		XCTAssertEqual(
			expectedName,
			project.name,
			file: file,
			line: line
		)
		XCTAssertEqual(
			expectedTargets,
			actualTargets,
			file: file,
			line: line
		)
	}
}
