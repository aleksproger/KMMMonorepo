//
//  Created by Kotov Max on 27.07.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation

@available(macOS 12.0, *)
public protocol URLSessionTwin {
	func upload(
		for request: URLRequest,
		from bodyData: Data
	) async throws -> (Data, URLResponse)

	func download(
		from url: URL
	) async throws -> (URL, URLResponse)

	func download(
		for request: URLRequest
	) async throws -> (URL, URLResponse)
}

@available(macOS 12.0, *)
extension URLSession: URLSessionTwin {
	public func upload(
		for request: URLRequest,
		from bodyData: Data
	) async throws -> (Data, URLResponse) {
		try await upload(for: request, from: bodyData, delegate: nil)
	}

	public func download(
		from url: URL
	) async throws -> (URL, URLResponse) {
		try await download(from: url, delegate: nil)
	}

	public func download(
		for request: URLRequest
	) async throws -> (URL, URLResponse) {
		try await download(for: request, delegate: nil)
	}
}
