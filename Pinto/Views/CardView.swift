//
//  CardView.swift
//  Pinto
//
//  Created by Cesar on 15/11/21.
//

import SwiftUI

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.default, size: CGSize(width: 30, height: 50), includeShadow: false)
    }
}


struct CardView: View {
    var card: Card
    var size: CGSize
    var includeShadow: Bool = true
    
    var body: some View {
        
            if(includeShadow){
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.9))
                    .shadow(radius: 8)
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
            }else {
                if(card.id < 0){
                    Image(systemName: card.content)
                        .font(.system(size: 65, weight: .ultraLight))
                        .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                        .foregroundColor(.orange)
                        .rotationEffect(Angle(degrees: 90.0))
                        
                } else {
                Image(card.content)
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .frame(width: thumbnailSize(size: size).width, height: thumbnailSize(size: size).height)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 1.3))
                    .clipped(antialiased: true)
                    .contentShape(Rectangle())
                }
            }
    }
}
