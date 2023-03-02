//
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol ProjectValidator {
	func validate(info: ProjectInfo) -> Result<Void, Error>
}
