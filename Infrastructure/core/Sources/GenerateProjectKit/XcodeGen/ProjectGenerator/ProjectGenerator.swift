//
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol ProjectGenerator {
	func generateProject(using: ProjectConfig) throws -> GeneratedProjectInfo
}
