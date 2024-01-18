//
//  DetailView.swift
//  Bookworm
//
//  Created by Игорь Верхов on 14.09.2023.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()

                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
            
            Text(book.author)
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
            HStack() {
                Spacer()
                Text(book.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        
        .alert("Delete books?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: delteteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you shure?")
        }
        
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func delteteBook() {
        modelContext.delete(book)
            dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4, date: .now)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
