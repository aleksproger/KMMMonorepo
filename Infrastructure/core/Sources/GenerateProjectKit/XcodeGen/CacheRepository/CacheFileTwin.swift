//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import Version
import XcodeGenCore

struct CacheFileTwin: Equatable {
	let string: String

	init(projectInfo: ProjectInfo) throws {
		let files = Set(projectInfo.project.allFiles)
			.map { ((try? $0.relativePath(from: projectInfo.project.basePath)) ?? $0).string }
			.sorted { $0.localizedStandardCompare($1) == .orderedAscending }
			.joined(separator: "\n")

		let data = try JSONSerialization.data(withJSONObject: projectInfo.projectDict, options: [.sortedKeys, .prettyPrinted])
		let spec = String(data: data, encoding: .utf8)!

		string = """
		# XCODEGEN VERSION
		\(XcodeGen.version)

		# SPEC
		\(spec)

		# FILES
		\(files)"

		"""
	}
}
