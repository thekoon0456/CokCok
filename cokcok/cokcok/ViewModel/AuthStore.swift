//
//  AuthStore.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthStore: ObservableObject {
    
    @Published var currentUser: Firebase.User?
    @Published var isLogin = false
    let database = Firestore.firestore()
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    // MARK: -Auth : 로그인 함수
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.currentUser = result?.user
                self.isLogin = true
            }
        }
    }
    
    // MARK: -Auth : 로그아웃 함수
    func logout() {
        currentUser = nil
        self.isLogin = false
		do {
			try Auth.auth().signOut()
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
        
    }
    
    // MARK: -Auth : 계정 생성
    // FIXME: -Alert 수정 :
    func registerUser(userName: String, userEmail: String, userPasssword: String, userBirthday : Date) {
        Auth.auth().createUser(withEmail: userEmail, password: userPasssword) { [self] result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let authUser = result?.user else { return }
            
            let user = UserInfo(id: authUser.uid,
                                userName: userName,
                                userEmail: userEmail,
                                userBirthday: userBirthday,
                                userShelf: [])
            addUserInfo(user)
        }
    }
    
    // MARK: -Method : User Create
    func addUserInfo(_ userInfo: UserInfo) {
        database.collection("UserInfo")
            .document(userInfo.id)
            .setData(["id" : userInfo.id,
                      "userName" : userInfo.userName,
                      "userEmail" : userInfo.userEmail,
                      "userBirthday" : userInfo.userBirthday,
                      "userShelf" : userInfo.userShelf])
    }
}

// MARK: -Extension : 로그인 / 회원가입 관련 함수 익스텐션
extension AuthStore {
    // MARK: -Regexp : 회원가입 텍스트필드 체크 정규식
    func checkNameRule(name : String) -> Bool {
        let regExp = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{2,8}$"
        return name.range(of: regExp, options: .regularExpression) != nil
    }
    
    func checkEmailRule(email : String) -> Bool {
        let regExp = #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]{2,3}+$"#
        return email.range(of: regExp, options: .regularExpression) != nil
    }
    
    func checkPasswordRule(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
    
    // MARK: - 이메일 중복 검사
        /// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
        /// 입력받은 이메일이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
        /// - Parameter currentUserEmail: 입력받은 사용자 이메일
        /// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
        @MainActor
        func isEmailDuplicated(currentUserEmail: String) async -> Bool {
            do {
                let document = try await database.collection("UserInfo")
                    .whereField("userEmail", isEqualTo: currentUserEmail)
                    .getDocuments()
                return !(document.isEmpty)
            } catch {
                print(error.localizedDescription)
                return false
            }
        }
        
        // MARK: - 닉네임 중복 검사
        /// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
        /// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
        /// - Parameter currentUserName: 입력받은 사용자 닉네임
        /// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
        @MainActor
        func isNameDuplicated(currentUserName: String) async -> Bool {
            do {
                let document = try await database.collection("UserInfo")
                    .whereField("userName", isEqualTo: currentUserName)
                    .getDocuments()
                return !(document.isEmpty)
            } catch {
                print(error.localizedDescription)
                return false
            }
        }
    
    
    // MARK: -Method : Date 타입의 날짜를 받아서 지정 형식(데이터베이스 저장 형태) 문자열로 반환하는 함수
    func getStringDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter.string(from: date)
    }
}




