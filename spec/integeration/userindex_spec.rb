require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  # Create some users with associated data
  let!(:user1) { FactoryBot.create(:user, name: 'User1') }
  let!(:user2) { FactoryBot.create(:user, name: 'User2') }
  let!(:user3) { FactoryBot.create(:user, name: 'User3') }
  let!(:user4) { FactoryBot.create(:user, name: 'User4') }

  before do
    # Create some posts for each user
    FactoryBot.create_list(:post, 2, author: user1)
    FactoryBot.create_list(:post, 3, author: user2)
    FactoryBot.create_list(:post, 1, author: user3)
    FactoryBot.create_list(:post, 4, author: user4)

    visit users_path
  end

  scenario 'User sees username, profile picture, and number of posts' do
    # Check if each user's username is visible
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user3.name)
    expect(page).to have_content(user4.name)

    # Check if each user's profile picture is visible (assuming you have image tags)
    expect(page).to have_css('img')

    # Check if the number of posts each user has written is visible
    expect(page).to have_content("Number of posts: #{user1.post_counter}")
    expect(page).to have_content("Number of posts: #{user2.post_counter}")
    expect(page).to have_content("Number of posts: #{user3.post_counter}")
    expect(page).to have_content("Number of posts: #{user4.post_counter}")
  end

  scenario 'User clicks on a user and is redirected to their show page' do
    # Click on a user's link
    first('ul a').click

    # Check if the page is redirected to the user's show page
    expect(page).to have_current_path(user_path(user1))
  end
end
