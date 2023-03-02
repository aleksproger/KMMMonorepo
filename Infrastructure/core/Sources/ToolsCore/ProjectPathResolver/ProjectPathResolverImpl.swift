//
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

public final class ProjectPathResolverImpl: ProjectPathResolver {
	enum ResolvingError: Error {
		case incorrectURL(directoryPath: String)
		case cannotAddPercentageEncoding(directoryPath: String)
	}

	private let basePath: String

	public init(basePath: String) {
		self.basePath = basePath
	}

	public func resolve(path: ProjectPath) -> Result<String, Error> {
		do {
			switch path {
			case let .rootRelative(relativePath):
				let fullURL = try makePercentageEncodedURL(basePath: basePath, relativePath: relativePath).get()
				return .success(fullURL.path)

			case let .relative(to: projectPath, relativePath):
				let basePath = try resolve(path: projectPath).get()
				let fullURL = try makePercentageEncodedURL(basePath: basePath, relativePath: relativePath).get()
				return .success(fullURL.path)

			case let .absolute(absolutePath):
				let expandedString = NSString(string: absolutePath).expandingTildeInPath
				let fullURL = try makePercentageEncodedURL(basePath: expandedString, relativePath: "").get()
				return .success(fullURL.path)
			}
		} catch {
			return .failure(error)
		}
	}

	private func makePercentageEncodedURL(
		basePath: String,
		relativePath: String
	) -> Result<URL, Error> {
		guard let encodedPath = basePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			return .failure(ResolvingError.cannotAddPercentageEncoding(directoryPath: basePath))
		}
		guard let pathURL = URL(string: encodedPath)?.appendingPathComponent(relativePath) else {
			print("Base: \(encodedPath), \n relative: \(relativePath)")
			return .failure(ResolvingError.incorrectURL(directoryPath: encodedPath))
		}

		return .success(pathURL)
	}
}
