//
//  ContentView.swift
//  Bookworm
//
//  Created by Игорь Верхов on 11.09.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Book.title, order: .forward),
        SortDescriptor(\Book.rating, order: .forward)
    ])var books: [Book]
    
    @State private var showingAddbookView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            HStack{
                            VStack {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text(book.date.formatted(.dateTime.day().month()))
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .opacity(book.rating == 1 ? 0.5 : 1)
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddbookView.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddbookView) {
                    AddBookView()
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]
            
            // delete it from the context
            modelContext.delete(book)
        }
    }
    
}

#Preview {
    ContentView()
}
