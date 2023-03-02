//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public protocol ProjectConfigBuilder {
	func config(_ projectName: String) -> ProjectGraphBuilderKit.ProjectConfig?
}
