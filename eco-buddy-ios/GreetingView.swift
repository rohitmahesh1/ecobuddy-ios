//
//  GreetingView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 02/10/23.
//

import SwiftUI

enum ProfileImage {
    case one
    case two
    case three
    case four
    case five
    case six
    
    var name: String{
        switch self {
        case .one:
            return "dp1"
        case .two:
            return "dp2"
        case .three:
            return "dp3"
        case .four:
            return "dp4"
        case .five:
            return "dp5"
        case .six:
            return "dp6"
        }
    }
}

struct GreetingView: View, KeyboardReadable {
    
    @State var txtName: String = ""
    @State var navigateHome = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isSubmitting = false
    @AppStorage("userName") var userName: String = ""
    @AppStorage("profileImage") var profileImage: String = ""
    @State private var isKeyboardVisible = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let profileImages: [ProfileImage] = [.one, .two, .three, .four, .five, .six]
    
    var isEditProfile: Bool

    private var trimmedName: String {
        txtName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func presentAlert(title: String, message: String = "") {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }

    private func submitName() {
        guard !trimmedName.isEmpty else {
            presentAlert(title: "Name can't be empty")
            return
        }

        let submittedName = trimmedName

        guard !isEditProfile else {
            userName = submittedName
            presentAlert(title: "Name changed successfully")
            return
        }

        isSubmitting = true

        PersistentStorage.shared.loadAllData { error in
            self.isSubmitting = false

            if let error {
                self.presentAlert(title: "Couldn't finish setup", message: error.localizedDescription)
                return
            }

            self.userName = submittedName

            if self.profileImage.isEmpty {
                self.profileImage = self.profileImages.randomElement()?.name ?? ""
            }

            self.navigateHome = true
        }
    }
    
    var body: some View {
        VStack {
            if !isEditProfile {
                AppNameView()
                    .padding(.top, UIDevice.hasTopNotch ? 28 : 10)
                    .opacity(isKeyboardVisible ? 0 : 1)
                Spacer()
            }
            
            
            if !UIDevice.hasTopNotch {
                Spacer()
            }
            
            VStack(spacing: 2) {
                FloatingBubbleTextView(
                    text: "Hi, My name is Buddy! \nWhat's yours?"
                )
                .opacity(isKeyboardVisible ? 0 : 1)
                GIFView(type: .name("greeting.turtle"))
                    .frame(width: 273, height: 269)
            }
            Spacer()
            
            VStack(spacing: UIDevice.hasTopNotch ? 32 : 18) {
                VStack {
                    TextField("Enter your name", text: $txtName)
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                            withAnimation {
                                isKeyboardVisible = newIsKeyboardVisible
                            }
                        }
                        .foregroundStyle(Color.black)
                        .font(.gilroyMedium(14))
                        .padding([.leading, .trailing], 18)
                }
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: -0.5)
                        .stroke(.black.opacity(0.2), lineWidth: 1)
                )
                .background(Color.white.cornerRadius(10, corners: .allCorners))
                .disabled(isSubmitting)
                CustomButtonView(
                    onTap: {
                        submitName()
                    },
                    title: isSubmitting ? "Setting Up..." : "Submit"
                )
                .disabled(isSubmitting)
                .opacity(isSubmitting ? 0.7 : 1)
            }
            .alert(isPresented: $isShowingAlert, content: {
                Alert(
                    title: Text(alertTitle),
                    message: alertMessage.isEmpty ? nil : Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            })
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            
            .onAppear(perform: {
                if isEditProfile {
                    self.txtName = userName
                }
            })
            
            NavigationLink(isActive: $navigateHome) {
                TabbarView().navigationBarBackButtonHidden()
            } label: {
                Text("")
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    if isEditProfile {
                        CustomBackButtonView()
                    }
                }
                ToolbarItem(placement: .principal) {
                    if isEditProfile {
                        Text("Edit Profile").font(.gilroyBold(20))
                    }
                }
            })
        }
        .background(
            Image("background.splash")
                .resizable()
                .ignoresSafeArea(.all)
        )
        .navigationBarHidden(!isEditProfile)
        .onBackSwipe {
            if isEditProfile {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    GreetingView(isEditProfile: false)
}
