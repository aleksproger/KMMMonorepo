//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import CommonCrypto
import Foundation

extension Data {
	public var sha1: String {
		var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
		withUnsafeBytes {
			_ = CC_SHA1($0.baseAddress, CC_LONG(count), &digest)
		}
		let hexBytes = digest.map { String(format: "%02hhx", $0) }
		return hexBytes.joined()
	}
}
