//
//  Created by Кудряшов Антон Сергеевич on 24.10.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import ToolsCore

public struct ProjectGraphBuilderKit {
	public let graphBuilder: ProjectGraphBuilder
	public let projectConfigBuilder: ProjectConfigBuilder

	public init(
		pathResolver: ProjectPathResolver,
		specLoader: SpecLoaderWrapper,
		fileManager: FileManagerTwin,
		shell: Shell
	) {
		let projectSpecLoader = ProjectSpecLoaderImpl(
			fileManager: fileManager,
			specLoader: specLoader,
			pathResolver: pathResolver,
			shell: shell
		)

		projectConfigBuilder = ProjectConfigBuilderImpl(
			specLoader: projectSpecLoader,
			shell: shell
		)

		graphBuilder = ProjectGraphBuilderImpl(
			projectConfigBuilder: projectConfigBuilder
		)
	}
}
