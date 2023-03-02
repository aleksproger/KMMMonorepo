//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public protocol ProjectPathResolver {
	func resolve(path: ProjectPath) -> Result<String, Error>
}
