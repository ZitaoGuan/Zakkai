//
//  SignInView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import FirebaseAuth
import SwiftUI

struct SignInView: View {
    @State var txtEmail: String = ""
    @State var txtPassword: String = ""
    @State var isRemember: Bool = false
    @State var showSignUp: Bool = false
    @State var showHome: Bool = false
    @State var showingInvalidCredentials = false
    @State var showingResetPasswordSheet = false
    
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
                        Task{
                            do {
                                let user = try await AuthenticationManager.shared.signIn(email: txtEmail, password: txtPassword)
                                showHome.toggle()
                                print("\(user) signed in")
                            } catch{
                                showingInvalidCredentials.toggle()
                                print("error: \(error)")
                            }
                        }
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
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .alert("Invalid Credentials", isPresented: $showingInvalidCredentials) {
        } message: {
            Text("Cannot find an account associated with those credentials")
        }
        .sheet(isPresented: $showingResetPasswordSheet){
            ResetPasswordView()
                .presentationDetents([.medium])
        }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
