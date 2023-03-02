//
//  Copyright © 2021 Sberbank. All rights reserved.
//

import Foundation

/// `Namespace` для `ASCII символов` разметки
/// - SeeAlso:
/// - https://en.wikipedia.org/wiki/ANSI_escape_code#SGR%20(Select%20Graphic%20Rendition)%20parameters
/// - https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
public enum ASCII {
	public enum Typo: String {
		/// Сброс всех прочих атрибутов (не заданных в его последовательности `csi`)
		case normal = "0"
		case bold = "1"
		case italic = "3"
		case underline = "4"
	}

	public enum Color: String {
		case black = "30"
		case red = "31"
		case green = "32"
		case yellow = "33"
		case blue = "34"
		case magenta = "35"
		case cyan = "36"
		case white = "37"
	}

	public static let escape = "\u{001B}"
	/// Control Sequence Introducer escape sequence
	/// - SeeAlso: https://en.wikipedia.org/wiki/ANSI_escape_code#CSI
	public static let csi = "["
	/// Select Graphic Rendition CSI sequence
	/// - SeeAlso: https://en.wikipedia.org/wiki/ANSI_escape_code#SGR
	public static let sgr = "m"
	public static let resetCsiAttributes = csi + "0" + sgr
}

extension String {
	public func asciiAttributed(
		typo: ASCII.Typo = .bold,
		color: ASCII.Color
	) -> String {
		ASCII.escape
			+ ASCII.csi
			+ typo.rawValue
			+ ";"
			+ color.rawValue
			+ ASCII.sgr
			+ self
			+ ASCII.escape
			+ ASCII.resetCsiAttributes
	}
}
