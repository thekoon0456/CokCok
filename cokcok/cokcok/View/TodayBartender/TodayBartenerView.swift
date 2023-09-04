//
//  TodayBartenerView.swift
//  cokcok
//
//  Created by Da Hae Lee on 2023/01/05.
//

import SwiftUI

// FIXME: 현재 더미데이터로, 질문-답변의 형식이 갖춰지면 제대로 값 부여할 것.
let questionList: [String] = [
    "어떤 맛을 선호하시나요?",         // SurveyAnswer.favoriteTaste
    "선호하는 향이 있으신가요?",         // SurveyAnswer.favoriteScent
    "도수는 어느 정도로 원하시나요?",    // SurveyAnswer.favoriteDegree
    "어떤 색상을 좋아하세요?",         // SurveyAnswer.favoriteColor
    "선호하는 베이스 술은 무엇인가요?"    // SurveyAnswer.favoriteBaseSpirit
]
let answerList: [[String]] = [
    ["달달한 맛", "상큼한 맛", "쓴맛", "향긋한 맛", "상관없어요"],     // 맛
    ["과일향", "열대과일향", "레몬향", "라임향", "커피향", "초코향", "허브향", "달콤한 향"], // 향
    ["10도 이하", "10도 ~ 29도 이하", "30도 이상"],      // 도수
    ["빨강", "노랑", "주황", "갈색", "검정", "초록", "파랑", "투명"], // 색상
    ["위스키", "브랜디", "진", "보드카", "데킬라", "럼", "리큐르", "상관없어요"]  // 베이스 술
]

struct TodayBartenerView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var stepCounter: Int = 0
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Image("surveyBg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {    // 질문 답변 뷰
                Text(questionList[stepCounter])
                    .font(.title3)
                    .bold()
                    .padding(30)
                Spacer()
                ForEach(answerList[stepCounter], id:\.self) { answer in
                    NavigationLink {
                        TodayBartenderStep2View(stepCounter: stepCounter+1, isShowing: $isShowing, beforeAnswer: answer)
                    } label: {
                        Text(answer)
                            .modifier(BasicButtonModifier())
                    }
                }
                Spacer()
            }
            .navigationTitle("콕콕🍸")
        }
    }
}


struct TodayBartenerView_Previews: PreviewProvider {
    @State static var isShowing = true
    
    static var previews: some View {
        NavigationStack {
            TodayBartenerView(isShowing: $isShowing)
        }
    }
}


