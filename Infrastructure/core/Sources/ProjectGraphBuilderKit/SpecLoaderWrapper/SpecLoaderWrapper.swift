//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ProjectSpec

public protocol SpecLoaderWrapper {
	var projectDictionary: [String: Any]? { get }

	func loadProject(
		path: String,
		projectRoot: String?,
		variables: [String: String]
	) -> Result<Project, Error>
}
