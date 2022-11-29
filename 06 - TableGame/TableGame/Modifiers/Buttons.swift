//
//  Buttons.swift
//  TableGame
//
//  Created by nicolas.e.manograsso on 29/11/2022.
//

import SwiftUI

extension Button {
    func principal(backgroundColor: Color = .green) -> some View {
        self
            .frame(width: 120)
            .padding(.vertical, 20)
            .background(backgroundColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
