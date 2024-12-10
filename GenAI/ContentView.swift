//
//  ContentView.swift
//  GenAI
//
//  Created by Shakti on 08/12/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    var model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "How can i help you today ?"
    @State var isLoading = false
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top,4)
            
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(4)
                }
            }
            
            TextField("Ask Anything...",text: $userPrompt, axis: .vertical)
                .lineLimit(5)
                .font(.title)
                .padding()
                .background(Color.indigo.opacity(0.2), in: Capsule())
                .autocorrectionDisabled(true)
                .onSubmit {
                    generateResponse()
                }
        }
        .padding()
    }
    
    // MARK: - FUNCTIONS
    func generateResponse(){
        isLoading = true
        response = ""
        
        Task{
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found.")
                userPrompt = ""
            } catch {
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ContentView()
}
