//
//  Date+.swift
//  cokcok
//
//  Created by 이승준 on 2023/01/06.
//

import Foundation

extension Date {
	public func getKoreanDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ko-KR")
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		return dateFormatter.string(from: self)
	}
}
