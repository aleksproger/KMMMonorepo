//
//  Copyright © 2022 Sberbank. All rights reserved.
//

public enum ProjectPath: Equatable, Hashable {
	indirect case relative(to: ProjectPath, String)
	case rootRelative(String)
	case absolute(String)
}
