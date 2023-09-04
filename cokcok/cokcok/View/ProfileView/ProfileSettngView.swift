//
//  ProfileSettngView.swift
//  cokcok
//
//  Created by 이승준 on 2023/01/06.
//

import SwiftUI
import FirebaseAuth

struct ProfileSettngView: View {
	@EnvironmentObject var profileViewModel: ProfileViewModel
	@EnvironmentObject var auth: AuthStore
	@Environment(\.dismiss) private var dismiss
	
	@State private var isLogoutToastShowed: Bool = false
	@State private var isNameTextFieldShow = false
	@State private var isNameTextFieldSubmitted = false
	
	@State private var isEmailTextFieldShow = false
	@State private var isEmailTextFieldSubmitted = false
	
	@State private var updateName = ""
	@State private var updateEmail = ""
	
    var body: some View {
		List {
			Section {
				Label {
					Text("이름 바꾸기")
						.bold()
				} icon: {
					Image(systemName: "person")
				}
				.onTapGesture {
					isNameTextFieldShow.toggle()
				}
				
				if isNameTextFieldShow {
					Label {
						TextField(isNameTextFieldSubmitted ? "업데이트 되었습니다!" : "새 이름을 입력해주세요", text: $updateName)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
						
						Spacer()
						
						Button {
							isNameTextFieldSubmitted = true
							Task {
                                await profileViewModel.updateUserInfo(in: Auth.auth().currentUser?.uid, with: .userName(value: updateName))
							}
						} label: {
							Image(systemName: isNameTextFieldSubmitted ? "checkmark.circle" : "arrow.up")
								.foregroundColor(isEmailTextFieldSubmitted ? .green : .accentColor)
						}
						.disabled(isNameTextFieldSubmitted || updateName.isEmpty)

					} icon: {
						Image(systemName: "pencil")
					}
				}
				
				Label {
					Text("이메일 바꾸기")
				} icon: {
					Image(systemName: "envelope")
				}
				.onTapGesture {
					isEmailTextFieldShow.toggle()
				}
				
				if isEmailTextFieldShow {
					Label {
						TextField(isEmailTextFieldSubmitted ? "업데이트 되었습니다!" : "새 이메일을을 입력해주세요", text: $updateEmail)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
						
						Spacer()
						
						Button {
							isEmailTextFieldSubmitted = true
							Task {
                                await profileViewModel.updateUserInfo(in: Auth.auth().currentUser?.uid, with: .userEmail(value: updateEmail))
							}
						} label: {
							Image(systemName: isEmailTextFieldSubmitted ? "checkmark.circle" : "arrow.up")
								.foregroundColor(isEmailTextFieldSubmitted ? .green : .accentColor)
						}
						.disabled(isEmailTextFieldSubmitted || updateEmail.isEmpty)
						
					} icon: {
						Image(systemName: "pencil")
					}
				}
			} header: {
				Text("개인정보 변경")
			}
			
			Section {
				Label {
					Text("로그아웃하기")
						.foregroundColor(.accentColor)
				} icon: {
					Image(systemName: "person.fill.xmark")
				}
				.onTapGesture {
					isLogoutToastShowed = true
				}
			} header: {
				Text("회원인증")
			}
		}
		.alert("로그아웃", isPresented: $isLogoutToastShowed) {
			Button("취소하기", role: .cancel) { }
			
			Button("로그아웃", role: .destructive) {
				auth.logout()
			}
		} message: {
			Text("정말 로그아웃 하시겠습니까?")
				.bold()
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Text("\(profileViewModel.userInfo!.userName) 님")
			}
		}
    }
}

struct ProfileSettngView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettngView()
    }
}
