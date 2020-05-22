//
//  FooterView.swift
//  yahn
//
//  Created by Faiz Mokhtar on 22/05/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .listRowInsets(EdgeInsets())
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
