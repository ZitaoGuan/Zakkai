//
//  SignInView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import LocalAuthentication
import FirebaseAuth
import SwiftUI

struct SignInView: View {
    
    @State private var txtEmail: String = ""
    @State private var txtPassword: String = ""
    @State private var isRemember: Bool = false
    @State private var showSignUp: Bool = false
    @State private var showHome: Bool = false
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    @State private var showingResetPasswordSheet = false
    
    @KeyChain(key: "faceID_email", account: "FaceIDLogin") var keychainEmail
    @KeyChain(key: "faceID_password", account: "FaceIDLogin") var keychainPass
    @AppStorage("biometricStatus") var biometricStatus = false
    
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
                
                RoundTextField(title: "Email", text: $txtEmail, keyboardType: .emailAddress)
                
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                
                
                
                RoundTextField(title: "Password", text: $txtPassword, isPassword: true)
                
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                
                
                HStack{
                    Button {
                        isRemember = !isRemember
                    } label: {
                        
                        HStack{
                            
                            Image(systemName: isRemember ? "checkmark.square" : "square")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text("Remember Password")
                                .multilineTextAlignment(.center)
                                .font(.customfont(.regular, fontSize: 14))
                        }
                        
                        
                        
                    }
                    .foregroundColor(.gray50)
                    
                    Spacer()
                    Button {
                        showingResetPasswordSheet.toggle()
                    } label: {
                        Text("Forgot Password")
                            .multilineTextAlignment(.center)
                            .font(.customfont(.regular, fontSize: 14))
                        
                    }
                    .foregroundColor(.gray50)
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                NavigationLink(destination: MainTabView(), isActive: $showHome) {
                    PrimaryButton(title: "Sign In", onPressed: {
                        signInUser(email: txtEmail, password: txtPassword)
                    })
                }
                
                Spacer()
                
                Text("if you don't have an account yet?")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 14))
                    .padding(.horizontal, 20)
                    .foregroundColor(.gray50)
                    .padding(.bottom, 20)
                
                NavigationLink(destination: SignUpView(), isActive: $showSignUp) {
                    SecondaryButton(title: "Sign Up", onPressed: {
                        showSignUp.toggle()
                    })
                }
                .padding(.bottom, .bottomInsets + 8)
            }
            .onAppear {
                
                // if user is enrolled in bioauthenticate
                if biometricStatus {
                    bioAuthenticate()
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .alert("Invalid Credentials", isPresented: $showingErrorAlert) {
        } message: {
            Text(errorMessage)
        }
        .sheet(isPresented: $showingResetPasswordSheet){
            ResetPasswordView()
                .presentationDetents([.medium])
        }
        
    }
    
    func bioAuthenticate() {
        
        // new context
        let context = LAContext()
        
        // handle errors
        var error: NSError?
        
        // if biometric authentication is supported
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics , error: &error) {
            let reason = "Authenticate To Unlock Your Account."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    
                    // login to firebase with keychain credentials
                    if let emailData = keychainEmail, let passwordData = keychainPass {
                        signInUser(email: String(data: emailData, encoding: .utf8) ?? "", password: String(data: passwordData, encoding: .utf8) ?? "")
                    }
                }
                else {
                    // failed to authenticate
                    if let error = error {
                        errorMessage = error.localizedDescription
                        showingErrorAlert.toggle()
                    }
                }
            }
        }
        else {
            //biometric authentication is not supported
        }
    }
    
    func signInUser(email: String, password: String) {
        Task{
            do {
                let user = try await AuthenticationManager.shared.signIn(email: email, password: password)
                showHome.toggle()
                print("\(user) signed in")
            } catch{
                errorMessage = error.localizedDescription
                showingErrorAlert.toggle()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
