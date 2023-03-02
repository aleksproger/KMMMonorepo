//
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol CacheWriter {
	func write(cache: String, to path: String) throws
}
