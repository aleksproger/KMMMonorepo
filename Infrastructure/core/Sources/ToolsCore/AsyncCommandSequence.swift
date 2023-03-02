//
//  Created by Kotov Max on 18.07.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

public struct AsyncCommandSequence {
	public typealias Command = () async throws -> Void

	private let errorHeader: String
	private let commands: [Command]
	private let errorFooter: String

	public init(
		errorHeader: String,
		commands: [Command],
		errorFooter: String
	) {
		self.errorHeader = errorHeader
		self.commands = commands
		self.errorFooter = errorFooter
	}

	public func run() async throws {
		var occurredErrors = [Error]()
		for command in commands {
			do {
				try await command()
			} catch {
				occurredErrors.append(error)
			}
		}

		if let errorList = ErrorList(
			header: errorHeader,
			errors: occurredErrors,
			footer: errorFooter
		) {
			throw errorList
		}
	}
}
