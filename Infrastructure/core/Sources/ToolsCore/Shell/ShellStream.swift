//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public enum ShellStream {
	case standart
	case error

	var fileHandler: FileHandle {
		switch self {
		case .standart:
			return FileHandle.standardOutput
		case .error:
			return FileHandle.standardError
		}
	}
}
