//
//  Copyright © 2021 Sberbank. All rights reserved.
//

public struct CommandSequence {
	public typealias Command = () throws -> Void

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

	public func run() throws {
		var occurredErrors = [Error]()
		commands.forEach {
			do {
				try $0()
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
