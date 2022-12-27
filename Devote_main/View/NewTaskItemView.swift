//
//  NewTaskItemView.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/27.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var task: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    private var isButtonDisabled : Bool {
        task.isEmpty
    }
    // MARK: - FUNCKTION
    private func addItem() {
        withAnimation{
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size:24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                        )
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24,
                                      weight: .bold,
                                      design: .rounded))
                        Spacer()
                })
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
            } //:VSTACK
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0 , opacity: 0.65), radius: 24)
            .frame(maxWidth:640)
        } // VSTACK
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView()
    }
}
