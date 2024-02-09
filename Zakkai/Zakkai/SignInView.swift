//
//  SignInView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct SignInView: View {
    @State var txtLogin: String = ""
    @State var txtPassword: String = ""
    @State var isRemember: Bool = false
    @State var showSignUp: Bool = false
    @State var showHome: Bool = false
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
                
                RoundTextField(title: "Login", text: $txtLogin, keyboardType: .emailAddress)
                
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                
                
                RoundTextField(title: "Passowrd", text: $txtPassword, isPassword: true)
                
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
                            
                            Text("Forgot Password")
                                .multilineTextAlignment(.center)
                                .font(.customfont(.regular, fontSize: 14))
                        }
                        
                        
                            
                    }
                    .foregroundColor(.gray50)
                    
                    Spacer()
                    Button {
                        
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
                            showHome.toggle()
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

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
