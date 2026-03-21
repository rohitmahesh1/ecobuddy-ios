////
////  CustomAlertView.swift
////  eco-buddy-ios
////
////  Created by Rohit Mahesh on 03/10/23.
////
//
//import SwiftUI
//
//struct LottieAlertView: View {
//    @State var play: Bool = false
//    var body: some View {
//        ZStack {
//            CustomAlertView()
//                
//            LottieView(loopMode: .loop, fileName: "celebration", play: $play)
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//               
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        
//    }
//}
//
//#Preview(body: {
//    LottieAlertView()
//})
//
//struct CustomAlertView: View {
//    @Environment(\.colorScheme) var colorScheme
//    var body: some View {
//        VStack {
//            VStack {
//                Text("Congratulations!")
//                    .foregroundStyle(Color.greenMain)
//                    .font(.gilroyBold(24))
//                    .padding(.top)
//                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
//                    .font(.gilroyMedium(12))
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(Color.gray)
//                    .padding([.leading, .trailing], 50)
//                    .padding(.top, 24)
//                
//                HStack {
//                    
//                    //CANCEL BTN
//                    Button(action: {
//                        print("onCancelPress")
//                    }, label: {
//                        Text("Cancel")
//                            .font(.gilroySemiBold(16))
//                            .foregroundStyle(Color.black)
//                            .padding([.top, .bottom], 10)
//                            .padding([.leading, .trailing], 38)
//                            .background(
//                                RoundedRectangle(cornerRadius: 4)
//                                    .foregroundStyle(Color.lightGray)
//                            )
//                    })
//                     
//                    //SHARE BTN
//                    Button {
//                        print("onShareTap")
//                    } label: {
//                        CustomShareButtonView(
//                            title: "Share",
//                            image: "icon.share.custom"
//                        )
//                    }
//
//                }
//                .padding(.top, 54)
//                .padding(.bottom, 18)
//                .padding([.leading, .trailing], 28)
//            }
//        }
//        .ignoresSafeArea(.all)
//        .preferredColorScheme(.dark)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(Color.white)
//        )
//    }
//}
//
//#Preview {
//    CustomAlertView()
//}
//
//
//struct CustomShareButtonView: View {
//    var title: String
//    var image: String
//    var body: some View {
//        VStack {
//            HStack {
//                Image(image)
//                Text(title)
//                    .font(.gilroySemiBold(16))
//                    .foregroundStyle(Color.white)
//            }
//            .padding([.leading, .trailing], 32)
//            .padding([.bottom, .top], 8)
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 4)
//                .foregroundStyle(Color.redMain)
//        )
//        .preferredColorScheme(.dark)
//    }
//}
//
//#Preview(body: {
//    CustomShareButtonView(title: "Share", image: "icon.share.custom")
//})
