//
//  BasicInputView.swift
//  
//
//  Created by Enes Karaosman on 19.10.2020.
//

import SwiftUI

public struct BasicInputView: View {
    @Binding public var message: String
    @FocusState.Binding public var isFocused: Bool
    public let placeholder: String
    
    public var onCommit: ((ChatMessageKind) -> Void)?
    
    public init(message: Binding<String>, isFocused: FocusState<Bool>.Binding, placeholder: String, onCommit: @escaping ((ChatMessageKind) -> Void)) {
        self._message = message
        self._isFocused = isFocused
        self.placeholder = placeholder
        self.onCommit = onCommit
    }
    
    public var body: some View {
        HStack {
            TextField(placeholder, text: $message, prompt: Text(placeholder))
            self.sendButton
        }
    }
    
    private var sendButton: some View {
        Button {
            self.onCommit?(.text(message))
            self.message.removeAll()
            self.isFocused = false
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

