//
//  UIFont+Name.swift
//  Pods
//
//  Created by 西村 拓 on 2016/04/08.
//
//

import UIKit

public extension UIFont {
	// http://iosfonts.com
	enum FontName: String {
		case AvenirLight = "Avenir-Light"
		case AvenirMedium = "Avenir-Medium"
		case AvenirHeavy = "Avenir-Heavy"
		case Copperplate = "Copperplate"
		case CopperplateBold = "Copperplate-Bold"
		case CopperplateLight  = "Copperplate-Light"
		case HelveticaNeue = "HelveticaNeue"
		case HelveticaNeueBold = "HelveticaNeue-Bold"
		case HelveticaNeueCondensedBlack = "HelveticaNeue-CondensedBlack"
		case HiraKakuProW3 = "HiraKakuProN-W3"
		case HiraKakuProW6 = "HiraKakuProN-W6"
		case HiraMinProW3 = "HiraMinProN-W3"
		case HiraMinProW6 = "HiraMinProN-W6"
		case OptimaRegular = "Optima-Regular"
		case OptimaItalic = "Optima-Italic"
		case OptimaBold = "Optima-Bold"
		case OptimaBoldItalic = "Optima-BoldItalic"
	}
	
	// Create font with name (Fource unwrap, becouse select name from avalable list)
	public convenience init(name fontName: FontName, size: CGFloat) {
		self.init(name: fontName.rawValue, size: size)!
	}
}
