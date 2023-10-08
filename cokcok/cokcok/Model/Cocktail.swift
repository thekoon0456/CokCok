//
//  Cocktail.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Foundation

struct Cocktail : Identifiable, Codable {
    var id: Int
    var cocktailName: String
    var cocktailImageUrl: String
    var description: String
    var degree: Int // 도수
    var taste: [String] // 맛
    var scent: [String] // 향
    var baseSpirit: String
    var isSparkling: Bool // 탄산
    var color: [String]
    var cocktailIcon: String //칵테일 플래티콘
}

enum CocktailName: String, Codable {
    case emptyCocktail1 = "emptyCocktail1"
    case emptyCocktail2 = "emptyCocktail2"
    case emptyCocktail3 = "emptyCocktail3"
    case emptyCocktail4 = "emptyCocktail4"
	case sideCar = "사이드카"
	case dirtyMother = "더티마더"
	case brandySour = "브랜디 사워"
	case jackRose = "잭 로즈"
	case brandyAlexander = "브랜디 알렉산더"
	case nineteenTwenty = "1920"
	case oldFashioned = "올드패션드"
	case rustyNail = "러스티 네일"
	case godFather = "갓파더"
	case whiskeySour = "위스키 사워"
	case manhattan = "맨해튼"
	case whiskeyHotToddy = "위스키 핫 토디"
	case whiskeyHighball = "위스키 하이볼"
	case jackCock = "잭콕"
	case greenField = "그린필드"
	case martini = "마티니"
	case gimlet = "김렛"
	case ginTonic = "진토닉"
	case handrixGinTonic = "핸드릭스 진토닉"
	case ginFizz = "진 피즈"
	case ramosGinFizz = "라모스 진 피즈"
	case negroni = "네그로니"
	case maitai = "마이타이"
	case daiquiri = "다이키리"
	case frozenDaiquiri = "프로즌 다이키리"
	case cubaLibre = "쿠바 리브레"
	case mojito = "모히또"
	case appleMojito = "애플 모히또"
	case moscowMule = "모스코 뮬"
	case cosmopolitan = "코스모폴리탄"
	case blackRussian = "블랙 러시안"
	case whiteRussian = "화이트 러시안"
	case balalaika = "발랄라이카"
	case kamikaze = "카미카제"
	case appleMartini = "애플 마티니"
	case vodkaTonic = "보드카 토닉"
	case margarita = "마가리타"
	case elDiablo = "엘디아블로"
	case tequilaSunrise = "데킬라 선라이즈"
	case grassHopper = "그래스호퍼"
	case absinthe = "압생트"
	case midoriSour = "미도리 사워"
	case saintGermainSour = "생제르맹 사워"
	case amarettoSour = "아마레또 사워"
	case chinaBlue = "차이나 블루"
	
	public func getEnglishName() -> String {
		switch self {
		case .emptyCocktail1:
			return "emptyCocktail1"
		case .emptyCocktail2:
			return "emptyCocktail2"
		case .emptyCocktail3:
			return "emptyCocktail3"
		case .emptyCocktail4:
			return "emptyCocktail4"
		case .sideCar:
			return "sideCar"
		case .dirtyMother:
			return "dirtyMother"
		case .brandySour:
			return "brandySour"
		case .jackRose:
			return "jackRose"
		case .brandyAlexander:
			return "brandyAlexander"
		case .nineteenTwenty:
			return "nineteenTwenty"
		case .oldFashioned:
			return "oldFashioned"
		case .rustyNail:
			return "rustyNail"
		case .godFather:
			return "godFather"
		case .whiskeySour:
			return "whiskeySour"
		case .manhattan:
			return "manhattan"
		case .whiskeyHotToddy:
			return "whiskeyHotToddy"
		case .whiskeyHighball:
			return "whiskeyHighball"
		case .jackCock:
			return "jackCock"
		case .greenField:
			return "greenField"
		case .martini:
			return "martini"
		case .gimlet:
			return "gimlet"
		case .ginTonic:
			return "ginTonic"
		case .handrixGinTonic:
			return "handrixGinTonic"
		case .ginFizz:
			return "ginFizz"
		case .ramosGinFizz:
			return "ramosGinFizz"
		case .negroni:
			return "negroni"
		case .maitai:
			return "maitai"
		case .daiquiri:
			return "daiquiri"
		case .frozenDaiquiri:
			return "frozenDaiquiri"
		case .cubaLibre:
			return "cubaLibre"
		case .mojito:
			return "mojito"
		case .appleMojito:
			return "appleMojito"
		case .moscowMule:
			return "moscowMule"
		case .cosmopolitan:
			return "cosmopolitan"
		case .blackRussian:
			return "blackRussian"
		case .whiteRussian:
			return "whiteRussian"
		case .balalaika:
			return "balalaika"
		case .kamikaze:
			return "kamikaze"
		case .appleMartini:
			return "appleMartini"
		case .vodkaTonic:
			return "vodkaTonic"
		case .margarita:
			return "margarita"
		case .elDiablo:
			return "elDiablo"
		case .tequilaSunrise:
			return "tequilaSunrise"
		case .grassHopper:
			return "grassHopper"
		case .absinthe:
			return "absinthe"
		case .midoriSour:
			return "midoriSour"
		case .saintGermainSour:
			return "saintGermainSour"
		case .amarettoSour:
			return "amarettoSour"
		case .chinaBlue:
			return "chinaBlue"
		}
	}
}
