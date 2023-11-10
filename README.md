# CokCok
앱스쿨 1기 해커톤 프로젝트 콕콕 리팩토링, 출시 프로젝트 (SwiftUI, MVVM)

### 당신의 취향을 위한 바텐더, 콕콕🍸
---

## ✨ 앱 소개(ADS)

- 이 앱은 칵테일을 처음 접하거나 관심 있는 사용자에게 각자 취향에 맞는 술을 추천해 주고, 사용자의 취향에 맞는 칵테일을 찾아갈 수 있도록 도와주는 '퍼스널 칵테일 큐레이팅' 앱입니다.
- 칵테일은 종류가 매우 다양하고 이름이 생소해 쉽게 접하기 어렵다고 생각하기 때문입니다.

---
## 🍸 앱의 기능과 역할

- 바에서 손님에게 칵테일을 추천해 줄 때처럼 사용자의 취향을 물어보고 그에 맞는 칵테일을 추천해 줍니다.
- 추천받은 칵테일이 취향에 맞으면 '내 술장'에 저장해 다음에 바에 방문했을 때도 취향에 맞는 칵테일을 주문을 할 수 있습니다.
- 사용자 개인별로 참여 미션을 제공하고, 미션을 달성하면 스탬프를 제공해 사용자의 참여를 격려합니다.

---
## 🍸 콕콕의 수익구조
- 로컬 바, 수입 주류회사들과 제휴를 맺고 배너광고를 통해 광고수입을 기대할 수 있습니다. 제휴 업체는 칵테일에 관심이 많은 사용자들에게 집중적으로 마케팅이 가능합니다.
- 사용자 개인별로 참여미션을 제공하고, 미션을 달성하면 제휴된 바와 주류회사의 쿠폰을 제공함으로서 사용자의 방문을 유도하고, 그에 따른 커미션을 기대할 수 있습니다.(지원예정)

---
## 📂 폴더 트리
<details>
  <summary>폴더 트리 </summary>
    <div markdown=“1”>
      <pre>
cokcok/
├─ cokcokApp.swift
├─ MogotgoMainTabView.swift
├─ ScaledImage.swift
├─ 📂 Extention/
│  └─ UIScreen + Extension.swift
│  └─- Date+.swift.swift
├─ 📂 UIConfig/
│  ├─ Colors.swift
│  └── Modifiers.swift
├─ 📂 View/
├--- ContentView.swift/
├─ 📂 AuthenticationView/
│  ├─ LoginView.swift
│  └── RegisterView.swift
├─ 📂 HomeView/
│  ├─ HomeView.swift
│  └─ HomeRecommendCard.swift
│  └── CocktailDetailView.swift
├─ 📂 ShelfView/
│  └── ShelfView.swift
├─ 📂 DictionaryView/
│  ├─ DictionaryView.swift
│  ├─ CocktailListCellView.swift
│  └── SearchFilterTagView.swift
├─ 📂 ProfileView/
│  ├─- MainProfileView.swift
├─ 📂 TodayBartender/
│  ├─ TodayBartenerView.swift
│  ├─ TodayBartenderStep2View.swift
│  ├─ TodayBartenderStep3View.swift
│  ├─ TodayBartenderStep4View.swift
│  ├─ TodayBartenderStep5View.swift
│  ├─ TodayBartenderResultView.swift
│  └── temp.swift
├─ 📂 ViewModel/
│  ├─ 📂 DictionaryViewModel/
│  │  └─ CocktailData.swift
│  │  └── CocktailStore.swift
│  ├─ 📂 ProfileViewModel/
│  │  └─ ProfileViewModel.swift
│  │  └── MissionViewModel.swift
│  └── AuthStore.swift
├─ 📂 Model/
│  ├─ UserInfo.swift
│  ├─ Cocktail.swift
│  ├─ MissionTable.swift
│  ├─ Mission.swift
│  ├─ SurveyAnswer.swift
│  └── Shelf.swift
├─ README.md
├─ .gitignore
└── .gitattribute
         </pre>
    </div>
</details>

---

## 🦉 앱 개발 환경

- Xcode Version 14.1 (14B47b)
- iPhone 14 Pro, iPhone 14 Pro + 에서 최적화됨, iPhone SE3까지 호환 가능
- 가로모드 미지원, 다크모드 지원

---
## 💸 주요 기능

- 사용자의 취향을 물어보고, 콕콕에서 취향에 맞는 칵테일을 추천해줍니다.
- 추천받은 칵테일이 취향에 맞으면 '내 술장'에 저장할 수 있습니다.
- 사용자에게 참여미션을 제공하고, 미션을 달성하면 스탬프로 보상합니다.


<details>
<summary> 앱 기능 상세 보기 </summary>
<div markdown="1">

---
## [앱의 일반기능]

- **회원가입**
    - Firebase Auth 연동 로그인
    - 정규식을 통해 회원가입 고도화
    - 로그인 완료 후, 사용자의 취향 분석 뷰로 이동

- **취향분석 뷰**
	- 칵테일에 대한 간단한 질문을 통해 사용자의 취향 분석
    - 취향 기반의 추천 칵테일 결과와 함께 홈뷰로 이동
    - 해당 칵테일이 취향에 맞으면 내 술장에 추가 가능

- **콕콕 사전**
  - 자체 데이터베이스 기반 칵테일 데이터 제공
  - 베이스 기주, 색깔, 도수, 맛, 탄산유무 등의 필터링 제공
    - 필터링된 칵테일을 내 술장에 추가 가능

- **내 술장**
	- 취향에 맞는 칵테일들을 내 술장에 보관 가능
    - 술장에 추가시 칵테일의 아이콘이 컬러풀하게 추가됨
    
- **프로필 뷰**
    - 사용자의 프로필 관리(닉네임, 이메일 등 유저 정보 수정)
    - 사용자에게 주어진 미션을 완료했을 시, 배지를 부여

---

</div>
</details>


## 👍 사용자 시나리오

1. 회원가입 시나리오
   -> 회원가입후 첫 칵테일 취향 설문(UserDefault) -> 응답후 추천 칵테일 결과창과 함께 홈뷰로 -> 설문에 참여하면 튜토리얼 도장 쾅!

2. 홈 시나리오
   ->_추천 칵테일이 없을시 -> 취향 설문으로 이동
   -> 추처 칵테일이 있을 때 해당 칵테일을 보여주고 -> 칵테일 상세뷰로 이동

3. 사전 시나리오
   -> 미리 칵테일 사전 데이터 만들기(칵테일 이름, 도수, 이미지, 베이스(럼or위스키 등), [색], [맛(단맛,쓴맛, 트로피컬한 맛)], 설명, is탄산?)
   a. 모든 속성이 검색에 걸릴 수 있도록 필터링

4. “프로필” 시나리오
   a. 설정창에서 유저의 정보 수정 가능
   b. 미션이 주어지고, 사용자가 해당 미션을 수행하면 축하 알림과 함께 뱃지가 주어짐 

## 🙆🏻‍♂️ 테스트 시나리오 및 환경

- [테스트 시나리오 확인하기](https://docs.google.com/spreadsheets/d/1T1xV4cg1UoBYE6fh29fVOJ2JuSGRhn0XCGXavplNvJI/edit#gid=0)
