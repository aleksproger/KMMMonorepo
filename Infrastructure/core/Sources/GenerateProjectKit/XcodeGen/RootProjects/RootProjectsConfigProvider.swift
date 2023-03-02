//
//  Created by Уразов Сергей Анатольевич on 26.08.2022.
//  Copyright © 2022 Sberbank. All rights reserved.
//

protocol RootProjectsConfigProvider {
	func rootProjects() -> [ProjectConfig]
}
