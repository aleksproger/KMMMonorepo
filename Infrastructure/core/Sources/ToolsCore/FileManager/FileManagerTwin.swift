//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public protocol FileManagerTwin {
	func fileExists(atPath path: String) -> Bool
	func createDirectory(
		atPath path: String,
		withIntermediateDirectories createIntermediates: Bool,
		attributes: [FileAttributeKey: Any]?
	) throws

	func contentsOfDirectory(atPath: String) throws -> [String]

	func copyItem(atPath: String, toPath: String) throws
	func removeItem(atPath: String) throws
}

extension FileManager: FileManagerTwin {}
