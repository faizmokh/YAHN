//
//  SecondaryButtonStyle.swift
//  yahn
//
//  Created by Faiz Mokhtar on 22/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.button.pressed : Color.button.normal)
            .cornerRadius(8.0)
    }

}
