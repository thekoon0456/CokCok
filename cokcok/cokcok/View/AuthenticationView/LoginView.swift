//
//  LoginView.swift
//  cokcok
//
//  Created by 원태영 on 2023/01/05.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authStore: AuthStore
    @State var email = ""
    @State var pw = ""
    @State var naviLinkActive : Bool = false
    @State private var isVisible : Bool = false
    @State private var isLoginClicked : Bool = false
    
    var body: some View {
        VStack(spacing : 30) {
            
            Image("cokcokLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width : 200)
            
            Spacer()
                .frame(height : 40)
            
            emailFiledSection
            passwordFieldSection
            loginButton
                .padding(.vertical, 50)
            LoginOptionButtonField
            
            Spacer()
                .frame(height : 30)
                
        }
        .padding()
    }
    
    
    // MARK: -View : 이메일 입력 필드
    private var emailFiledSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "envelope.circle.fill")
                Text("이메일")
            }
            .foregroundColor(Color.accentColor)
            
            TextField("이메일을 입력해주세요", text: $email)
                .modifier(LoginTextFieldModifier())
        }
    }
    
    // MARK: -View : 패스워드 입력 필드
    private var passwordFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "key")
                Text("비밀번호")
                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible
                          ? "eye" : "eye.slash")
                }
            }
            .foregroundColor(Color.accentColor)
            .padding(.top)
            
            if isVisible {
                TextField("비밀번호를 입력해주세요", text: $pw)
                    .modifier(LoginTextFieldModifier())
            } else {
                SecureField("비밀번호를 입력해주세요", text: $pw)
                    .modifier(LoginTextFieldModifier())
            }
            
        }
    }
    
    
    // MARK: -Button : 로그인 버튼
    private var loginButton : some View {
        Button {
            authStore.login(email: email, password: pw)
            isLoginClicked = true
        } label: {
            Text("로그인")
        }
        .modifier(ButtonModifier())
        .disabled(isLoginClicked)
        
    }
    
    // MARK: -Button : 회원가입 버튼
    private var registerButton : some View {
        NavigationLink(isActive : $naviLinkActive) {
            RegisterView(naviLinkActive: $naviLinkActive)
                .navigationTitle("회원가입")
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("회원가입")
        }
        
    }
    
    
    // MARK: -View : 아이디 / 비밀번호 찾기, 회원가입 버튼 Stack
    private var LoginOptionButtonField : some View {
        HStack {
            Button {
                print("아이디 찾기 버튼 클릭")
            } label: {
                Text("아이디 찾기")
            }
            
            Text(" | ")
            
            Button {
                print("비밀번호 찾기 버튼 클릭")
            } label: {
                Text("비밀번호 찾기")
            }
            
            Text(" | ")
            
            registerButton
        }
        .foregroundColor(Color.accentColor)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



