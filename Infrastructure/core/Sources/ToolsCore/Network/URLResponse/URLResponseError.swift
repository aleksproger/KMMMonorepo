//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public enum URLResponseError: Error {
	case unauthorized
	case unavailable
	case inappropriateResponse(Int)
}
