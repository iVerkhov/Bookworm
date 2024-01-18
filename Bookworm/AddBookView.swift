//
//  AddBookView.swift
//  Bookworm
//
//  Created by Игорь Верхов on 12.09.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var isValid: Bool {
        title.isEmpty || author.isEmpty || review.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(isValid)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
