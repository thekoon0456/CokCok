//
//  RegisterView.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import SwiftUI

// TODO: -
/// 1. 가입 완료 텍스트 띄워주고 1초 후 나가기 - [완료]
/// 2. 하단 중복확인 텍스트 안내 방식 변경
/// 3. 텍스트필드 포커스 문제 해결
/// 4. infoCheck 상수 추가 - [완료]
/// 5. navititle modifier로 묶기 - [완료]
/// 6. if문으로 offset 내리기
/// 7. placeHolder를 라벨로 이동시키기
/// 8. 입력 완료 상수 추가 - [완료]
/// 9. 주석 작업
/// 10. 네비게이션 타이틀 Modifier - [완료]
/// 11. 비밀번호 visible 버튼 라벨 옆으로 이동 - [완료]
/// 12. 로그인 버튼 클릭 후 disable - [완료]

enum HelpDescription : String {
    case name = "이름을 알려주세요!\n"
    case email = "이메일을 입력해주세요!\n"
    case password = "비밀번호를 입력해주세요!\n"
    case passwordCheck = "비밀번호를 한번 더 입력해주세요!"
    case infoCheck = "님! 이 정보가 맞나요?"
    case registSuccess = "회원가입이 완료되었어요. 반가워요 "
}

enum RegisterDepth {
    case name, email, password, passwordCheck, infoCheck, registSuccess
}

enum Field : String, Hashable {
    case name = "이름"
    case email = "이메일"
    case password = "패스워드"
    case passwordCheck = "패스워드 확인"
}

struct RegisterView: View {
    // MARK: -Properties
    let progressButtonText : String = "입력 완료"
    
    // MARK: -State
    @EnvironmentObject var authStore : AuthStore
    @FocusState private var focusedField : Field?
    
    // 회원가입 진행 Depth
    @State private var helpDescription : HelpDescription = .name
    @State private var registerDepth : RegisterDepth = .name
    
    // 중복확인 안내 문구
    @State private var nameDuplicateDescription : String = "\n"
    @State private var emailDuplicateDescription : String = "\n"
    
    @State private var isPasswordVisible : Bool = false
    @State private var isPasswordCheckVisible : Bool = false
    
    @State private var nameField : String = ""
    @State private var confirmName: String = ""
    @State private var emailField : String = ""
    @State private var confirmEmail: String = ""
    @State private var passwordField : String = ""
    @State private var passwordCheckField : String = ""
    @State private var nameCheck = false
    @State private var emailCheck = false
    @State private var showingAlert = false
    @Binding var naviLinkActive : Bool
    
    // MARK: -Computed Properties
    /// 이름 정규식 체크
    var isNameRule: Bool {
        return authStore.checkNameRule(name: nameField)
    }
    /// 이메일 정규식 체크
    var isEmailRule : Bool {
        return authStore.checkEmailRule(email: emailField)
    }
    /// 비밀번호 정규식 체크
    var isPasswordRule : Bool {
        return authStore.checkPasswordRule(password: passwordField)
    }
    /// 비밀번호 & 비밀번호 확인 일치 여부 체크
    var isPasswordsSame : Bool {
        return !passwordField.isEmpty && passwordField == passwordCheckField
    }
    /// 현재 이름 & 중복 체크 완료 이름 일치 여부 체크
    var isConfirmName : Bool {
        return confirmName == nameField
    }
    /// 현재 이메일 & 중복 체크 완료 이메일 일치 여부 체크
    var isConfirmEmail : Bool {
        return confirmEmail == emailField
    }
    /// 모든 조건 체크
    var isAllTrue : Bool {
        return isNameRule && isEmailRule && isPasswordRule &&
        isPasswordsSame && isConfirmName && isConfirmEmail
    }
    
    
    // MARK: -Main View
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            
            // 최상단 안내 문구
            HStack {
                switch helpDescription {
                case .infoCheck:
                    Text(nameField + helpDescription.rawValue)
                case .registSuccess:
                    Text(helpDescription.rawValue + nameField + "님!")
                default:
                    Text(helpDescription.rawValue)
                }
                Spacer()
            }
            .modifier(TitleModifier())
            
            withAnimation {
                
                Group {
                    switch registerDepth {
                    case .name:
                        nameFiledSection
                    case .email:
                        emailFiledSection
                        nameFiledSection
                    case .password:
                        passwordFieldSection
                        emailFiledSection
                        nameFiledSection
                    case .passwordCheck:
                        passwordCheckFieldSection
                        passwordFieldSection
                        emailFiledSection
                        nameFiledSection
                    case .infoCheck:
                        passwordCheckFieldSection
                        passwordFieldSection
                        emailFiledSection
                        nameFiledSection
                    case .registSuccess:
                        EmptyView()
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            focusedField = .name
        }
        .padding(30)
        .overlay(alignment : .bottom) {
            switch registerDepth {
            case .name:
                nameButtonGroup
            case .email:
                emailButtonGroup
            case .password:
                passwordApplyButton
            case .passwordCheck:
                passwordCheckApplyButton
            case .infoCheck:
                signUpButton
            case .registSuccess:
                EmptyView()
            }
        }
        .padding(.bottom, 80)
    }
    
    
    // MARK: 이름 관련 Components
    
    // MARK: -View : 이름 입력 필드
    private var nameFiledSection : some View {
        VStack(alignment: .leading) {
            // 라벨링
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(Color.accentColor)
                Text("이름")
                
            }
            // 텍스트 필드
            HStack {
                if registerDepth == .name {
                    TextField("이름", text: $nameField)
                        .onChange(of: nameField) { value in
                            if nameField != confirmName {
                                nameDuplicateDescription = "\n"
                                nameCheck = false
                            }
                        }
                        .modifier(RegisterTextFieldModifier(targetField: $nameField))
                } else {
                    Text(nameField)
                }
            }
            .font(.title3)

            Spacer()
                .frame(height : 20)
            
                if registerDepth == .name {
                    if isNameRule {
                        Text("사용 가능한 이름이에요.\n")
                            .foregroundColor(Color.cokcokGreen)
                            .font(.subheadline)
                        
                    } else if nameField.isEmpty == false {
                        
                        Text("이름은 2~8자의 공백, 특수기호를 제외한 문자로만 가능해요.\n")
                            .foregroundColor(Color.cokcokRed)
                            .font(.subheadline)
                        
                    } else {
                        Text("\n")
                            .font(.subheadline)
                    }
                }
            
        }
    }
    
    // MARK: 이메일 관련 Components
    
    // MARK: -View : 이메일 입력 필드
    private var emailFiledSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "envelope.circle.fill")
                    .foregroundColor(Color.accentColor)
                Text("이메일")
                
            }
            
            HStack {
                if registerDepth == .email {
                    TextField("이메일", text: $emailField)
                        .focused($focusedField, equals: .email)
                        .onChange(of: emailField) { value in
                            if emailField != confirmEmail {
                                emailDuplicateDescription = "\n"
                                emailCheck = false
                            }
                        }
                        .modifier(RegisterTextFieldModifier(targetField: $emailField))
                } else {
                    Text(emailField)
                }
            }
            .font(.title3)
            
            Spacer()
                .frame(height : 20)
            
            if registerDepth == .email {
                if isEmailRule {
                    Text("사용 가능한 이메일이에요.\n")
                        .foregroundColor(Color.cokcokGreen)
                        .font(.subheadline)
                    
                } else if emailField.isEmpty == false {
                    Text("유효하지 않은 이메일 형식이에요.\n")
                        .foregroundColor(Color.cokcokRed)
                        .font(.subheadline)
                } else {
                    Text("\n")
                        .font(.subheadline)
                }
            }
        }
    }
    
    
    
    // MARK: -View : 패스워드 입력 필드
    private var passwordFieldSection : some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "key")
                    .foregroundColor(Color.accentColor)
                Text("비밀번호")
                
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible
                          ? "eye" : "eye.slash")
                }
            }
            
            HStack {
                if registerDepth == .password {
                    Group {
                        if isPasswordVisible {
                            TextField("비밀번호", text: $passwordField)
                        } else {
                            SecureField("비밀번호", text: $passwordField)
                        }
                    }
                    .modifier(RegisterTextFieldModifier(targetField: $passwordField))
                } else {
                    Text(isPasswordVisible
                         ? passwordField
                         : String(repeating: "●",
                                  count: passwordField.count))
                }
                
                Spacer()
                
                
            }
            .font(.title3)
            
            Spacer()
                .frame(height : 20)
            
            Group {
                if registerDepth == .password {
                    if isPasswordRule {
                        Text("사용 가능한 비밀번호에요.\n")
                            .foregroundColor(Color.cokcokGreen)
                    } else if passwordField.isEmpty == false {
                        Text("비밀번호는 영문, 숫자, 특수문자를 포함하여 8~20자로 구성되어야해요.")
                            .foregroundColor(Color.cokcokRed)
                    } else {
                        Text("\n")
                    }
                }
            }
            .font(.subheadline)
        }
    }
    
    // MARK: -View : 패스워드 확인 입력 필드
    private var passwordCheckFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "key.fill")
                    .foregroundColor(Color.accentColor)
                Text("비밀번호 확인")
                
                Button {
                    isPasswordCheckVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible
                          ? "eye" : "eye.slash")
                }
                
            }
            
            HStack {
                
                if registerDepth == .passwordCheck {
                    Group {
                        if isPasswordCheckVisible {
                            TextField("비밀번호 확인",
                                      text: $passwordCheckField)
                        } else {
                            SecureField("비밀번호 확인",
                                        text: $passwordCheckField)
                        }
                    }
                    .modifier(RegisterTextFieldModifier(targetField: $passwordCheckField))
                } else {
                    Text(isPasswordCheckVisible
                         ? passwordCheckField
                         : String(repeating: "●",
                                  count: passwordCheckField.count))
                }
                
            }
            .font(.title3)
            
            Spacer()
                .frame(height : 20)
            
            Group {
                if registerDepth == .passwordCheck {
                    if isPasswordsSame {
                        Text("일치하는 비밀번호에요.\n")
                            .foregroundColor(Color.cokcokGreen)
                    } else if passwordCheckField.isEmpty == false {
                        
                        Text("비밀번호가 일치하지 않아요.\n")
                            .foregroundColor(Color.cokcokRed)
                        
                    } else {
                        Text("\n")
                    }
                }
            }
            .font(.subheadline)
            .frame(maxWidth : .infinity)
        }
        
    }
    
    // MARK: -하단 Depth 진행 버튼 그룹
    // MARK: -Button : 이름 중복 확인 버튼
    private var nameDuplicateCheckButton : some View {
        Button {
            Task {
                if await !authStore.isNameDuplicated(currentUserName: nameField) {
                    nameDuplicateDescription = "[\(nameField)]은(는) 사용 가능한 이름이에요!"
                    nameCheck.toggle()
                    confirmName = nameField
                } else {
                    nameDuplicateDescription = "[\(nameField)]은(는) 중복된 이름이에요.다른 이름을 사용해주세요!"
                }
            }
        } label: {
            Text("중복 확인")
                .modifier(ButtonModifier())
        }
        .disabled(nameField.isEmpty || !isNameRule)
    }
    
    // MARK: -Button : 이름 확인 버튼
    private var nameApplyButton : some View {
        Button {
            helpDescription = .email
            registerDepth = .email
            focusedField = .email
            nameDuplicateDescription = "\n"
        } label : {
            Text(progressButtonText)
                .modifier(ButtonModifier())
        }
    }
    
    // MARK: -ButtonGroup : 이름 Depth 진행
    private var nameButtonGroup : some View {
        Group {
            if nameCheck {
                nameApplyButton
            } else {
                nameDuplicateCheckButton
            }
        }
        .overlay {
            Text(nameDuplicateDescription)
                .offset(y: -60)
                .frame(maxWidth : .infinity, alignment : .leading)
                .lineLimit(2)
        }
    }
    
    
    
    
    
    // MARK: -Button : 이메일 중복 확인 버튼
    private var emailDuplicateCheckButton : some View {
        Button {
            Task {
                if await !authStore.isEmailDuplicated(currentUserEmail: emailField) {
                    emailDuplicateDescription = "[\(emailField)]은(는) 사용 가능한 이메일이에요!"
                    emailCheck.toggle()
                    confirmEmail = emailField
                } else {
                    emailDuplicateDescription = "[\(emailField)]은(는) 이미 가입이 된 이메일이에요!"
                }
            }
        } label: {
            Text("중복 확인")
                .modifier(ButtonModifier())
        }
        .disabled(emailField.isEmpty || !isEmailRule)
    }
    
    // MARK: -Button : 이메일 확인 버튼
    private var emailApplyButton : some View {
        Button {
            helpDescription = .password
            registerDepth = .password
            focusedField = .password
            emailDuplicateDescription = "\n"
        } label : {
            Text(progressButtonText)
                .modifier(ButtonModifier())
        }
    }
    
    // MARK: -ButtonGroup : 이메일 Depth 진행
    private var emailButtonGroup : some View {
        Group {
            if emailCheck {
                emailApplyButton
            } else {
                emailDuplicateCheckButton
            }
        }
        .overlay {
            Text(emailDuplicateDescription)
                .offset(y: -60)
                .frame(maxWidth : .infinity, alignment : .leading)
        }
    }
    
    
    
    
    // MARK: -Button : 패스워드 확인 버튼
    private var passwordApplyButton : some View {
        Button {
            helpDescription = .passwordCheck
            registerDepth = .passwordCheck
            focusedField = .passwordCheck
            
        } label : {
            Text(progressButtonText)
                .modifier(ButtonModifier())
        }
        .disabled(!isPasswordRule)
    }
    
    // MARK: -Button : 패스워드 체크 확인 버튼
    private var passwordCheckApplyButton : some View {
        Button {
            helpDescription = .infoCheck
            registerDepth = .infoCheck
        } label : {
            Text(progressButtonText)
                .modifier(ButtonModifier())
        }
        .disabled(!isPasswordsSame)
    }
    
    
    // MARK: -Button : 회원가입 시도 버튼
    private var signUpButton : some View {
        
        Button {
            authStore.registerUser(userName: nameField,
                                   userEmail: emailField,
                                   userPasssword: passwordField,
                                   userBirthday: Date())
            helpDescription = .registSuccess
            registerDepth = .registSuccess
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                naviLinkActive = false
            }
        } label: {
            Text("네! 가입할게요")
                .modifier(ButtonModifier())
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var isShow = false
    
    static var previews: some View {
        RegisterView(naviLinkActive: $isShow)
            .environmentObject(AuthStore())
    }
}

