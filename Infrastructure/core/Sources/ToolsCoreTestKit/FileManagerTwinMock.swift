//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

public final class FileManagerTwinMock: FileManagerTwin {
	public enum Input: Equatable {
		case fileExists(path: String)
		case createDirectory(path: String, withIntermediates: Bool)
		case contentsOfDirectory(path: String)
		case copyItem(atPath: String, toPath: String)
		case removeItem(atPath: String)
	}

	public private(set) var inputs = [Input]()

	public init() {}

	public var isFileExist = true
	public lazy var isFileExistHandler: (String) -> Bool = { _ in self.isFileExist }
	public func fileExists(atPath path: String) -> Bool {
		inputs.append(.fileExists(path: path))
		return isFileExistHandler(path)
	}

	public var createDirectoryResult: Result<Void, Error> = .failure(TestError(description: "mock"))
	public func createDirectory(
		atPath path: String,
		withIntermediateDirectories createIntermediates: Bool,
		attributes _: [FileAttributeKey: Any]?
	) throws {
		inputs.append(.createDirectory(path: path, withIntermediates: createIntermediates))
		try createDirectoryResult.get()
	}

	public var contentsOfDirectory: Result<[String], Error> = .failure(TestError(description: "mock"))
	public func contentsOfDirectory(atPath: String) throws -> [String] {
		inputs.append(.contentsOfDirectory(path: atPath))
		return try contentsOfDirectory.get()
	}

	public var copyResult: Result<Void, Error> = .failure(TestError(description: "mock"))
	public func copyItem(atPath: String, toPath: String) throws {
		inputs.append(.copyItem(atPath: atPath, toPath: toPath))
		_ = try copyResult.get()
	}

	public var removeResult: Result<Void, Error> = .failure(TestError(description: "mock"))
	public func removeItem(atPath: String) throws {
		inputs.append(.removeItem(atPath: atPath))
		_ = try removeResult.get()
	}
}
