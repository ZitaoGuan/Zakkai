//
//  SignUpView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State var txtEmail: String = ""
    @State var txtPassword: String = ""
    @State var showSignIn: Bool = false
    @State var showingPasswordAlert = false
    @State var showingEmailAlert = false
    
    var body: some View {
        ZStack{
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
                        
            VStack{
                
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .widthPer(per: 0.5) )
                    .padding(.top, .topInsets + 8)
                
                
                Spacer()
                
                RoundTextField(title: "Email Address", text: $txtEmail, keyboardType: .emailAddress)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                RoundTextField(title: "Password", text: $txtPassword, isPassword: true)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                HStack {
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                        .foregroundStyle(firstBar() ? .green : .gray70)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                        .foregroundStyle(secondBar() ? .green : .gray70)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                        .foregroundStyle(thirdBar() ? .green : .gray70)
                    
                    Rectangle()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 5, maxHeight: 5)
                        .padding(.horizontal, 1)
                        .foregroundStyle(fourthBar() ? .green : .gray70)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("Use 8 or more characters with a mix of letters,\nnumbers & symbols.")
                    .multilineTextAlignment(.leading)
                    .font(.customfont(.regular, fontSize: 14))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray50)
                    .padding(.bottom, 20)
                
                PrimaryButton(title: "Get Started, it's free!", onPressed: {
                    signUp()
                })
                
                Spacer()
                
                Text("Do you have already an account?")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray50)
                    .padding(.bottom, 20)
                
                NavigationLink(destination: SignInView(), isActive: $showSignIn) {
                        SecondaryButton(title: "Sign In", onPressed: {
                            showSignIn.toggle()
                        })
                }
                .padding(.bottom, .bottomInsets + 8)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .alert("Invalid Password", isPresented: $showingPasswordAlert) {
        } message: {
            Text("Please choose a stronger password")
        }
        .alert("Invalid Email", isPresented: $showingPasswordAlert) {
        }
    }
    
    func signUp() {
        
        guard firstBar() else {
            showingPasswordAlert.toggle()
            return;
        }
        
        guard txtEmail.isValidEmail() else{
            showingEmailAlert.toggle()
            return
        }
        
        Task {
            do{
                let newUser = try await AuthenticationManager.shared.createUser(email: txtEmail, password: txtPassword)
                print("user created: \(newUser)")
            }catch{
                print("error: \(error)")
            }
        }
    }
    
    func firstBar() -> Bool {
        return txtPassword.count >= 8 && txtPassword.numCount() >= 1 && txtPassword.symbolCount() >= 1
    }
    
    func secondBar() -> Bool {
        return txtPassword.count >= 10 && txtPassword.numCount() >= 2 && txtPassword.symbolCount() >= 1
    }

    func thirdBar() -> Bool {
        return txtPassword.count >= 12 && txtPassword.numCount() >= 2 && txtPassword.symbolCount() >= 1
    }
    
    func fourthBar() -> Bool {
        
        return txtPassword.count >= 16 && txtPassword.numCount() >= 2 && txtPassword.symbolCount() >= 1
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension String {
    func numCount() -> Int {
        var numCount = 0
        for char in self {
            if char.isNumber{
                numCount += 1
            }
        }
        return numCount
    }
    
    func symbolCount() -> Int {
        var symbolCount = 0
        for char in self {
            if char.isSymbol || char.isPunctuation{
                symbolCount += 1
            }
        }
        return symbolCount
    }
}
