//
//  BasicInputView.swift
//  
//
//  Created by Enes Karaosman on 19.10.2020.
//

import SwiftUI

public struct BasicInputView: View {
    @Binding var message: String
    @Binding var isEditing: Bool
    let placeholder: String
    
    var onCommit: ((ChatMessageKind) -> Void)?
    
    public var body: some View {
        HStack {
            TextField(placeholder, text: $message, prompt: Text(placeholder))
            self.sendButton
        }
        //        .padding(10)
        //        .frame(maxWidth: .infinity)
        //        .background(Color.syllyInput)
        //        .cornerRadius(20)
        //        .frame(maxWidth: .infinity)
        //        .padding(20)
    }
    
    private var sendButton: some View {
        Button {
            self.onCommit?(.text(message))
            self.message.removeAll()
        } label: {
            Circle().fill(Color.accentColor)
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .offset(x: -1, y: 1)
                        .padding(8)
                )
        }
        .disabled(message.isEmpty)
    }
}

