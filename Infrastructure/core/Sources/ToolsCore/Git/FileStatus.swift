//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

enum FileStatus: String {
	case modified = "M"
	case copyEdit = "C"
	case renameEdit = "R"
	case added = "A"
	case deleted = "D"
	case unmerged = "U"
}
