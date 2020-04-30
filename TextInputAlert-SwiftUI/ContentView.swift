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
                Button(action: { self.showingCustomAlert.toggle() }){
                    Text("Show custom alert")
                }
                Button(action: { self.showingNormalAlert.toggle() }) {
                    Text("Show normal alert")
                }
                .alert(isPresented: $showingNormalAlert) {
                    Alert(title: Text("Add player"), message: Text("Please enter a name for your new player. Don't be silly!"), dismissButton: .cancel())
                }
            }
            if showingCustomAlert {
                TextInputAlertView(showingModal: self.$showingCustomAlert, titleText: "Add player", placeholderText: "Enter a name", bodyText: "Please enter a name for your new player. Don't be silly!") { value in
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
