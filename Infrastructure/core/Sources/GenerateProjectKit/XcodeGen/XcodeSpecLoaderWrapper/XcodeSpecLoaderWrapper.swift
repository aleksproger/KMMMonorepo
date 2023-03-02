//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import PathKit
import ProjectSpec
import ToolsCore
import Version
import ProjectGraphBuilderKit

public final class XcodeSpecLoaderWrapper: SpecLoaderWrapper {
	public private(set) var projectDictionary: [String: Any]?
	private let specLoader: SpecLoader

	public init() {
		specLoader = SpecLoader(version: XcodeGen.version)
	}

	public func loadProject(
		path: String,
		projectRoot _: String?,
		variables _: [String: String]
	) -> Result<Project, Error> {
		do {
			let project = try specLoader.loadProject(
				path: Path(path),
				projectRoot: nil,
				variables: [:]
			)

			projectDictionary = specLoader.projectDictionary

			return .success(project)
		} catch {
			return .failure(error)
		}
	}
}
