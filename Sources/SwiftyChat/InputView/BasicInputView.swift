//
//  BasicInputView.swift
//  
//
//  Created by Enes Karaosman on 19.10.2020.
//

import SwiftUI

public struct BasicInputView: View {
    @Binding public var message: String
    @Binding public var scrollToBottom: Bool
    public let placeholder: String
    
    public var onCommit: ((ChatMessageKind) -> Void)?
    
    @FocusState private var isFocused: Bool
    
    public init(message: Binding<String>, scrollToBottom: Binding<Bool>, placeholder: String, onCommit: @escaping ((ChatMessageKind) -> Void)) {
        self._message = message
        self._scrollToBottom = scrollToBottom
        self.placeholder = placeholder
        self.onCommit = onCommit
    }
    
    public var body: some View {
        HStack {
            TextField(placeholder, text: $message, prompt: Text(placeholder))
                .focused($isFocused)
                .onChange(of: isFocused) { _ in
                    scrollToBottom = true
                }
            self.sendButton
        }
    }
    
    private var sendButton: some View {
        Button {
            self.onCommit?(.text(message))
            self.message.removeAll()
            withAnimation {
                isFocused = false
                withAnimation {
                    scrollToBottom = true
                }
            }
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

