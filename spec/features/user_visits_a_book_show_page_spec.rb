require 'rails_helper'

describe 'User visits book show' do
  it 'shows single book attributes' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Sharks", pages: 200, year: 1965)

    visit book_path(book_1)

    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.pages)
    expect(page).to have_content(book_1.year)
    expect(page).to_not have_content(book_2.title)
  end 

  it 'show the reviews for a single book' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)

    visit book_path(book_1)

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.description)
    expect(page).to have_content(review_1.score)

    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.description)
    expect(page).to have_content(review_2.score)
  end 
end