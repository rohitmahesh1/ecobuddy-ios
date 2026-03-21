//
//  ChallengeDetailsView.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import SwiftUI
import AVFoundation
import WebKit
import SDWebImageSwiftUI



struct ChallengeDetailsView: View {
    
    struct SubChallengeVM {
        let uid: UUID = UUID()
        let subChallenge: SubChallenge
        var onTap: (() -> ())?
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showPopup: Bool = false
    
    var challenge: Challenge?
    private var persistantStorage: PersistantStorage
    
    @State var subChallenges: [SubChallengeVM] = []
    @State var selectedSubChallenge: SubChallenge?
    
    @ObservedObject var imageViewModel = SDWebImageViewModel()
    
    
    init(persistantStorage: PersistantStorage = PersistantStorage.shared, challenge: Challenge?, isPledge: Bool = false) {
        self.isPledge = isPledge
        self.persistantStorage = persistantStorage
        self.challenge = challenge
    }
    
    var isPledge: Bool = false
    var isAllTaskDone: Bool {
        return !subChallenges.contains(where: { $0.subChallenge.challengeStatus == false }) || subChallenges.isEmpty
    }
    
    var atleastOneDone: Bool {
        return subChallenges.contains(where: { $0.subChallenge.challengeStatus == true }) || subChallenges.isEmpty
    }
    
    var challengeCompletion: Bool {
        return isAllTaskDone && (challenge?.isCompleted ?? false)
    }
    
    func completeChallenge() {
        guard let challenge else { return }
        self.persistantStorage.editChallenge(challenge, isDone: isAllTaskDone) {
            print("Edited Challenge")
        }
    }
    
    private func getSubChallenges() {
        guard let challenge = challenge else { return }
        let subChallengeIds = challenge.subChallengeIds
        
        let subChallenges = persistantStorage.getSubChallenges().filter { subChallenge in
            subChallengeIds.contains(subChallenge.wrappedSubChallengeId)
        }
        
        self.subChallenges = subChallenges.map({ subChallenge in
            return SubChallengeVM(
                subChallenge: subChallenge,
                onTap: {
                    self.selectedSubChallenge = subChallenge
                    self.persistantStorage.editSubTask(subChallenge, isDone: subChallenge.challengeStatus) {
                        self.persistantStorage.editChallenge(challenge, isDone: self.isAllTaskDone) {
                            print("Edited challenge and sub challenge completion")
                            self.getSubChallenges()
                        }
                    }
                }
            )
        })
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let challengeImageURL = challenge?.challengeImage {
                    WebImage(url: challengeImageURL)
                        .resizable()
                        .placeholder(content: {
                            ProgressView()
                                .foregroundStyle(.black)
                        })
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .clipped()
                } else {
                    GeometryReader { geometry in
                        Color.greenMain
                            .frame(height: geometry.safeAreaInsets.top + 4)
                            .edgesIgnoringSafeArea(.top)
                        YoutubeVideoView(youtubeVideoID: challenge?.challengeVideoURL?.convertUrl?.extractVideoID() ?? "")
                            .frame(height: 210)
                            .padding(.top, 8)
                    }
                    .frame(height: 210)
                }
                
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(challenge?.wrappedChallengeTitle ?? "")
                            .font(.gilroySemiBold(16)).lineSpacing(4)
                            .multilineTextAlignment(.leading)
                        Text(LocalizedStringKey(challenge?.wrappedChallengeDescription ?? ""))
                            .font(.gilroyRegular(14))
                            .lineSpacing(5)
                            .multilineTextAlignment(.leading)
                        
                        if !isPledge {
                            ForEach(self.subChallenges.indices, id: \.self) { index in
                                let subChallengeVM = subChallenges[index]
                                SubtaskCell(
                                    checkBox: subChallengeVM.subChallenge.challengeStatus,
                                    onTap: {
                                        subChallengeVM.onTap?()
                                    },
                                    count: "\(index + 1)",
                                    title: subChallengeVM.subChallenge.wrappedChallengeTitle
                                )
                            }
                            
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                }
                
                Spacer()
                
                
                CustomButtonView(
                    onTap: {
                        completeChallenge()
                        withAnimation {
                            self.showPopup = true
                        }
                    },
                    title: isPledge ? "Take the pledge" : "Complete Challenge"
                )
                .opacity(atleastOneDone ? 1 : 0.5)
                .disabled(!atleastOneDone)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, UIDevice.hasTopNotch ? 0 : 10)
                
            }
            
            .onBackSwipe {
                presentationMode.wrappedValue.dismiss()
            }
            .frame(width: UIScreen.main.bounds.width)
            
            if showPopup {
                PopupView(
                    allTaskDone: isAllTaskDone,
                    onCancelTap: {
                        withAnimation {
                            showPopup = false
                        }
                    },
                    onShareTap: {
                        self.imageViewModel.onShareTap(challenge: self.challenge)
                    },
                    onInstaShare: {
                        self.imageViewModel.onShareTap(challenge: self.challenge, true)
                    },
                    isPledge: self.isPledge
                )
            }
        }
        .sheet(isPresented: $imageViewModel.showShareSheet, content: {
            ShareSheet(photo: imageViewModel.image ?? UIImage(), text: challenge?.wrappedChallengeTitle ?? "")
        })
        .frame(width: UIScreen.main.bounds.width)
        
        .onAppear(perform: {
            getSubChallenges()
        })
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(challenge?.challengeImage != nil ? .top : .leading )
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                if !showPopup {
                    CustomBackButtonView()
                }
            }
        })
        
    }
}

struct PopupView: View {
    var allTaskDone: Bool
    var onCancelTap: (() -> ())?
    var onShareTap: (() -> ())?
    var onInstaShare: (() -> ())?
    var isPledge: Bool
    
    var title: String {
        isPledge ? "You've successfully taken the pledge.\nThank you for your commitment." : "You've successfully completed \nthe challenge. Well done!"
    }
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.4)
                .ignoresSafeArea()
            VStack {
                ZStack {
                    GIFView(type: .name("turtle2"))
                        .frame(width: 228, height: 224)
                    LottieView(loopMode: .loop, animationName: "celebration_ratio")
                        .frame(width: UIScreen.main.bounds.width, height: 224)
                    LottieView(loopMode: .loop, animationName: "celebration-bottom-ratio")
                        .frame(width: UIScreen.main.bounds.width, height: 0)
                }
                .frame(width: UIScreen.main.bounds.width, height: 224)
                .padding(.top, -70)
                
                Text(!allTaskDone ? "Keep going!"  : "Congratulations!")
                    .font(.gilroyBold(24))
                    .padding(.top, 18)
                    .foregroundStyle(Color.greenMain)
                
                Text(!allTaskDone ? "You are on right track! \n Complete whole challenges!" : title)
                    .font(.gilroyMedium(16))
                    .foregroundColor(Color(red: 0.51, green: 0.57, blue: 0.63))
                    .multilineTextAlignment(.center)
                    .padding(.top, 24)
                
                VStack(spacing: 20) {
                    
                    if allTaskDone {
                        Button {
                            self.onInstaShare?()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(height: 40)
                                    .foregroundStyle(Color(red: 0.92, green: 0.27, blue: 0.2))
                                
                                HStack(spacing: 6) {
                                    Image("icon.instagram")
                                    Text("Share")
                                        .font(.gilroySemiBold(16))
                                        .foregroundStyle(Color.white)
                                }
                                
                            }
                            
                        }
                    }
                    
                    Button {
                        self.onCancelTap?()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .frame(height: 40)
                                .foregroundStyle(allTaskDone ? Color(red: 0.93, green: 0.93, blue: 0.93) : .blue)
                            
                            Text(!allTaskDone ? "Ok" : "Done")
                                .font(.gilroySemiBold(16))
                                .foregroundStyle(allTaskDone ? Color(red: 0.21, green: 0.21, blue: 0.21) : .white)
                        }
                        
                    }
                    
                }
                .padding(.top, 46)
                .padding([.leading, .trailing], 48)
                .padding(.bottom, 18)
                
                
                
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 20)
            )
        }
        .background(
            Color.black.opacity(0.2)
        )
    }
}

class SDWebImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var showShareSheet = false
    
    func onShareTap(challenge: Challenge?, _ isInstagram: Bool = false) {
        let image: URL?
        if let challengeImage = challenge?.challengeImage {
            image = challengeImage
        } else {
            image = challenge?.challengeVideoURL?.convertUrl?.extractVideoID()?.thumnailURL.convertUrl
        }
        SDWebImageManager.shared.loadImage(with: image) { _, _, _ in
        } completed: { image, data, error, _, _, _ in
            if error == nil {
                DispatchQueue.main.async {
                    if isInstagram {
                        InstagramManager.instance.postImage(image: image ?? UIImage())
                    } else {
                        self.image = image
                        self.showShareSheet = true
                    }
                }
            } else { print("error downloading image") }
                
        }
    }
}
