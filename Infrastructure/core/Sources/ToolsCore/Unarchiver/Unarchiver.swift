//
//  Copyright © 2021 Sberbank. All rights reserved.
//

public protocol Unarchiver {
	func unarchive(from: String, to: String) throws
}
