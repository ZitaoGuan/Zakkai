//
//  AddCreditCardView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/14/24.
//

import SwiftUI

struct AddCreditCardView: View {
    
    @State var txtAccountNumber: String = ""
    @State var txtRoutingNumber: String = ""

    var body: some View {
        ZStack{
            Image("welcome_screen")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            ScrollView
            {
                VStack{
                    
                    ZStack{
                        HStack{
                            Button {
                                
                            } label: {
                                Image("back")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            
                            Spacer()
                            
                        }
                        
                        HStack{
                            Spacer()
                            
                            Text("Settings")
                                .font(.customfont(.regular, fontSize: 16))
                            
                            
                            Spacer()
                            
                        }
                    }
                    .foregroundColor(.black)
                }.padding(.top, .topInsets)

                
                VStack(spacing: 4){
                    
                    Spacer()
                    
                    RoundTextField(title: "Account Number", text: $txtAccountNumber, keyboardType: .emailAddress)
                    
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    
                    
                    RoundTextField(title: "Routing Number", text: $txtRoutingNumber, isPassword: true)
                    
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        
    }
}

struct AddCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCreditCardView()
    }
}
