//
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol CacheLoader {
	func loadCache(from path: String) -> Result<String?, Error>
}
