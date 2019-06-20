//
//  ContentView.swift
//  SwiftUI-Animation
//
//  Created by Andre Martingo on 20.06.19.
//  Copyright © 2019 Andre Martingo. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State var showModal = false
    
    private var transition: AnyTransition {
        let insertion = AnyTransition.scale()
            .combined(with: .opacity)
        let removal = AnyTransition.scale()
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Button(action: { self.showModal = true }, label: { Text("Show modal")})
                    .navigationBarTitle(Text("Home"))


            if showModal {
                ModalDimmingView() {
                    self.showModal = false
                }
                .transition(.opacity)
                
                VStack {
                    Spacer()
                    ModalPlaylistView() {
                        self.showModal = false
                    }
                    Spacer()
                }
                .transition(transition)
                .animation(.spring(damping: 15))
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


struct ModalPlaylistView: View {
    
    var action: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("Modal")
                
            Button(action: action) {
                HStack {
                    Spacer()
                    Text("Hide").padding([.top, .bottom], 8.0)
                    Spacer()
                }
                }
                .relativeWidth(1.0)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8.0)
            }
            .padding()
    }
}

struct ModalDimmingView : View {
    
    var action: () -> Void = {}
    
    var body: some View {
        Color
            .black
            .relativeWidth(1.0)
            .relativeHeight(1.0)
            .opacity(0.3)
            .edgesIgnoringSafeArea([.bottom, .top])
            .tapAction { self.action() }
    }
}
