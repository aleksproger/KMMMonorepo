//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public struct ToolsEnvironment {
	public var verbose: Bool {
		let env = ProcessInfo.processInfo.environment["VERBOSE"]?.bool
		return env ?? false
	}

	public var isDryRun: Bool {
		let env = ProcessInfo.processInfo.environment["SD_DRY_RUN"]?.bool
		return env ?? false
	}
}

extension String {
	fileprivate var bool: Bool? {
		switch self.lowercased() {
		case "true",
			 "t",
			 "yes",
			 "y",
			 "1":
			return true
		case "false",
			 "f",
			 "no",
			 "n",
			 "0":
			return false
		default:
			return nil
		}
	}
}

public let toolsEnv = ToolsEnvironment()
