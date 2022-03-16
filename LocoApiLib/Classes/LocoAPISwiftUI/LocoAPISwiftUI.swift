//
//  LocoAPISwiftUI.swift
//  Loco API Test
//
//  Created by Morgan Berger on 11/03/2022.
//

import SwiftUI

struct LocoAPILibLoadingModifier<Instead: View>: ViewModifier {
    @State var isReady: Bool = false
    let insteadView: Instead
    
    @StateObject var obs = LocalsManagerObservable()
    
    func body(content: Content) -> some View {
        ZStack {
            if obs.state.isReady {
                content
                    .transition(.opacity.animation(.easeInOut))
            } else {
                insteadView
                    .transition(.opacity.animation(.easeInOut))
            }
        }
        .environmentObject(obs)
    }
}

extension View {
    func locoAPILoading<Instead: View>(instead: () -> Instead) -> some View {
        self
            .modifier(LocoAPILibLoadingModifier(insteadView: instead()))
    }
}
