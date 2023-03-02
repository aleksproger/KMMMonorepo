//
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public protocol Git {
	/// Корневой путь директории git репозитория.
	func topLevel() throws -> String

	/// Название Git ветки.
	func branchName() throws -> String

	/// Получить список измененных файлов.
	func changedFiles() throws -> [String]

	/// Найти первый общий коммит между двумя ветками
	func findFirstCommonCommit(
		firstBranch: String,
		secondBranch: String
	) throws -> String

	/// Список всех коммитов начиная с указанного
	func commitsSince(commit: String, in branch: String) throws -> [String]
}
