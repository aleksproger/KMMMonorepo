//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public protocol URLSessionFactory {
	func make() -> URLSession
}
