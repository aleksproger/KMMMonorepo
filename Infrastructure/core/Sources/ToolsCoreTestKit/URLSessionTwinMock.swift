//
//  Created by Kotov Max on 27.07.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

import Foundation
import ToolsCore

// swiftlint:disable duplicate_enum_cases
@available(macOS 12.0, *)
public final class URLSessionTwinMock: URLSessionTwin {
	public enum Input: Equatable {
		case upload(URLRequest, Data)
		case download(request: URLRequest)
		case download(url: URL)
	}

	public init() {}

	public var inputs = [Input]()

	public var uploadResult: Result<(Data, HTTPURLResponse), Error> = .success((Data(), HTTPURLResponse()))
	public func upload(
		for request: URLRequest,
		from bodyData: Data
	) async throws -> (Data, URLResponse) {
		inputs.append(.upload(request, bodyData))

		return try uploadResult.get()
	}

	public var downloadResult: Result<(URL, HTTPURLResponse), Error> = .success((
		URL(string: "www.sber.ru")!,
		HTTPURLResponse()
	))

	public func download(
		from url: URL
	) async throws -> (URL, URLResponse) {
		inputs.append(.download(url: url))
		return try downloadResult.get()
	}

	public func download(
		for request: URLRequest
	) async throws -> (URL, URLResponse) {
		inputs.append(.download(request: request))
		return try downloadResult.get()
	}
}
