//
//  ContentView.swift
//  Devote_main
//
//  Created by yeomim Kim on 2022/12/02.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task : String = ""
    @State private var showNewTaskItem : Bool = false
    
    private var isButtonDisabled : Bool{ task.isEmpty
    }
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTION
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    // BODY
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack(spacing: 10) {
                        Text("Devote")
                            .font(.system(.largeTitle
                                          ,design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        //EditButton
                        EditButton()
                            .font(.system(size: 16,
                                          weight: .semibold,
                                          design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                        
                        // apperance button
                        Button(action: {
                            //toggle appearance
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ?
                                  "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .frame(width: 24, height:24)
                            .font(.system(.title, design: .rounded))
                        })
                    } //HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
//
                    
                    // MARK: - new task button
                    
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30,
                                          weight: .semibold,
                                          design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold
                                          , design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal , 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    //mark - tasks
                    
                    List {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }// : LIST ITEM
                        .onDelete(perform: deleteItems)
                    }//: LIST
//                    .listStyle(InsetGroupedListStyle())
                    .cornerRadius(20)
                    .listStyle(.insetGrouped)
                    .padding(20)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }//: VSTACK
            } // : ZSTACK
            .scrollContentBackground(.hidden)
        
//            .navigationBarTitle("Daily Tasks", displayMode: .large )
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                } //:TOOLBAR
//#endif
//            } //: Toolbar
            .background(
              BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all))
        }//: navigation
        .navigationViewStyle(StackNavigationViewStyle())
    } //:VIEW
} // contView


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
