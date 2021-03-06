require 'rails_helper'

describe 'user visits user show page' do
  it 'shows information for one user' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "A book about Jones", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_2.reviews.create(title: "Fish are better than Sharks", description: "Fish are friends", score: 3, user: user_1)

    visit book_path(book_1)

    first(:link, "Joey Fatone").click

    expect(current_path).to eq(user_reviews_path(user_1))
    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.score)
    expect(page).to have_content(review_1.description)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.score)
    expect(page).to have_content(review_2.description)
  end

  it 'displays working link to delete review' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "A book about Jones", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_2.reviews.create(title: "Fish are better than Sharks", description: "Fish are friends", score: 3, user: user_1)

    visit user_reviews_path(user_1)
    expect(page).to have_content(review_1.title)

    first(:link, "Delete").click
    expect(page).to_not have_content(review_1.title)

  end

  it 'sort reviews based on created_at' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "A book about Jones", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1, created_at: "2018-07-12")
    review_2 = book_2.reviews.create(title: "Fish are better than Sharks", description: "Fish are friends", score: 3, user: user_1, created_at: "2018-08-13")

    visit user_reviews_path(user_1)
    click_on("Newest")
    within("#created-at-5") do
      expect(page).to have_content(review_1.created_at.strftime("%m-%d-%Y"))
    end 
  end
end
