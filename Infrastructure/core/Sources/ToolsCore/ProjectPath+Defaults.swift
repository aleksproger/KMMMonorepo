//
//  Copyright © 2022 Sberbank. All rights reserved.
//

extension ProjectPath {
	public static var projectsPath: ProjectPath {
		.rootRelative("Mobile/Apps/iOS")
	}

	public static func directoryPath(_ name: String) -> ProjectPath {
		.rootRelative("Mobile/Apps/iOS/\(name)/")
	}

	public static func xcSpecPath(_ name: String) -> ProjectPath {
		.rootRelative("Mobile/Apps/iOS/\(name)/project.yml")
	}

	public static func xcCachePath(_ name: String) -> ProjectPath {
		.rootRelative("Infrastructure/.cache/xcodegen/\(name).d")
	}
}
