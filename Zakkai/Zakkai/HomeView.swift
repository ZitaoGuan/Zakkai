//
//  HomeView.swift
//  Zakkai
//
//  Created by Zitao Guan on 2/7/24.
//

import SwiftUI

struct HomeView: View {
    @State var isSubscription: Bool = true
    @State var subArr: [SubscriptionModel] = [
        SubscriptionModel(dict: ["name":"Feeding America", "icon":"Feeding_America", "price": "0.59"] )
        ,
        SubscriptionModel(dict: [
            "name": "St. Jude",
            "icon": "St. Jude",
            "price": "0.49"] )
        ,
        SubscriptionModel(dict: ["name": "Salvation Army",
                                 "icon": "Salvation_army",
                                 "price": "0.69"] )
        ,
        SubscriptionModel(dict: ["name": "Direct Relief", "icon": "Direct Relief", "price": "0.79"] )
    ]
    
    var body: some View {
        ZStack {
                    Image("welcome_screen") // Set the background image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .ignoresSafeArea()
        ScrollView {
            
            ZStack(alignment: .center) {
                ZStack{
                    ArcShape()
                        .foregroundColor(.gray.opacity(0.2))
                    
                    ArcShape(start: 0, end: 230)
                        .foregroundColor(.secondaryC)
                        .shadow( color: .secondaryC.opacity(0.5) , radius: 7)
                }
                .frame(width: .widthPer(per: 0.72), height: .widthPer(per: 0.72) )
                .padding(.bottom, 18)
                
                VStack(spacing: .widthPer(per: 0.07)){
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .widthPer(per: 0.25) )
                    
                    Text("$1,235")
                        .font(.customfont(.bold, fontSize: 40))
                        .foregroundColor(.white)
                    
                    Text("Donated")
                        .font(.customfont(.semibold, fontSize: 12))
                        .foregroundColor(.gray40)
                    
                    Button {
                       
                    } label: {
                        Text("View past Donation")
                            .font(.customfont(.semibold, fontSize: 12))
                    }
                    .foregroundColor( .white )
                    
                    .padding(10)
                    .background(Color.gray60.opacity(  0.2 ))
                    .overlay {
                        RoundedRectangle(cornerRadius:  16)
                            .stroke( Color.gray70, lineWidth: 1)
                    }
                    .cornerRadius(16)
                }

            }
            .frame(width: .screenWidth, height: .widthPer(per: 1.1) )
            
            HStack{
                
                SegmentButton(title: "Your Subscription", isActive: isSubscription) {
                    isSubscription.toggle()
                }
                
                SegmentButton(title: "Upcomming bills", isActive: !isSubscription) {
                    isSubscription.toggle()
                }
                
            }
            .padding(8)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)
            .padding()
            ZStack{
                
                if(isSubscription) {
                    LazyVStack(spacing: 15) {
                        ForEach( subArr , id: \.id) { sObj in
                            
                            SubScriptionHomeRow(sObj: sObj)
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    
                }
                
                if(!isSubscription) {
                    LazyVStack(spacing: 15) {
                        ForEach( subArr , id: \.id) { sObj in
                            
                            UpcomingBillRow(sObj: sObj)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
