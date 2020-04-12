//
//  ContentView.swift
//  TextInputAlert-SwiftUI
//
//  Created by Aidan Pendlebury on 12/04/2020.
//  Copyright © 2020 Aidan Pendlebury. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var myValue = ""
    @State private var showingCustomAlert = false
    @State private var showingNormalAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Text(myValue)
                Button(action: {
                    self.showingCustomAlert.toggle()
//                    withAnimation(.easeOut) { self.showingCustomAlert.toggle() }
                }){
                    Text("Show custom alert")
                }
                Button(action: { self.showingNormalAlert.toggle() }) {
                    Text("Show normal alert")
                }
                .alert(isPresented: $showingNormalAlert) {
                    Alert(title: Text("This is the title"), message: Text("This is the body text."), dismissButton: .cancel())
                }
            }
            if showingCustomAlert {
                TextInputAlertView(showingModal: self.$showingCustomAlert, titleText: "My title", placeholderText: "Input a value please", bodyText: "What would you like to say?") { value in
                    self.myValue = value
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
