//
//  TextInputAlertView.swift
//  TextInputAlert-SwiftUI
//
//  Created by Aidan Pendlebury on 12/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct TextInputAlertView: View {
    
    @Binding var showingModal: Bool
    @State private var scale: CGFloat = 0.1
    @State private var showingValidationError = false
    @State private var answerText = ""
    @State private var yOffset = 0
    
    var titleText = ""
    var placeholderText = ""
    var bodyText = ""
    var buttonText = "Ok"
    var action: (String) -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Text(titleText).bold().padding(.top)
                Text(bodyText).font(.subheadline)
                    .lineLimit(5)
                    .padding(.bottom)
                    .padding(.horizontal)
                    .padding(.top, 5)
                TextField(placeholderText, text: $answerText)
                    .padding(8)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(showingValidationError ? Color.red : Color(UIColor.systemGray4), lineWidth: 1)
                )
                    .font(.subheadline)
                    .padding(.horizontal, 30)
                    .padding(.bottom)
                Divider()
                HStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: { self.showingModal.toggle() } ) { Text("Cancel")}
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Spacer()
                        Button(action: self.returnTextFieldInput) { Text("Action") }.padding()
                        Spacer()
                    }
                }.frame(height: 50)
            }
        .frame(maxWidth: 400)
            .background(colorScheme == .light ?  Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaleEffect(scale)
            .padding(50)
            .onAppear {
                withAnimation(.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 10, initialVelocity: 50)) { self.scale = 1 }
            }
            .offset(CGSize(width: 0, height: self.yOffset))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)) { _ in
            withAnimation { self.yOffset = -80 }
        }
    }
    
    func returnTextFieldInput() {
        guard !answerText.isEmpty else {
            showingValidationError = true
            return
        }
        self.action(answerText)
        self.showingModal.toggle()
    }
}

struct TextInputAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputAlertView(showingModal: .constant(true), titleText: "Title", placeholderText: "Enter a type of food. Don't do it", bodyText: "Do you like to eat food? Of course you do. Who on earth doesn't like food?", action: { _ in })
            .previewLayout(.sizeThatFits)
    }
}

