//
//  Copyright © 2022 Sberbank. All rights reserved.
//

@testable import ProjectGraphBuilderKit
import ProjectSpec
import ToolsCoreTestKit

public final class SpecLoaderWrapperMock: SpecLoaderWrapper {
	public var projectDictionary: [String: Any]? = [:]

	public enum Input: Equatable {
		case loadProject(
			path: String,
			root: String?,
			variables: [String: String]
		)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var loadResult: Result<Project, Error> = .failure(TestError(description: "mock"))
	public func loadProject(
		path: String,
		projectRoot: String?,
		variables: [String: String]
	) -> Result<Project, Error> {
		inputs.append(.loadProject(
			path: path,
			root: projectRoot,
			variables: variables
		))
		return loadResult
	}
}
