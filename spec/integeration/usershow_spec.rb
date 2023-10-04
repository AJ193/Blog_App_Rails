require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  # Create a user with associated data
  let!(:user) { FactoryBot.create(:user, name: 'TestUser', bio: 'This is a test bio.') }

  before do
    # Create some posts for the user
    FactoryBot.create_list(:post, 5, author: user)

    visit user_path(user)
  end

  scenario 'User sees user details, bio, and posts' do
    # Check if user's profile picture is visible (assuming you have an image tag)
    expect(page).to have_css('img') # Adjust this selector as needed

    # Check if user's username is visible
    expect(page).to have_content(user.name)

    # Check if user's bio is visible
    expect(page).to have_content(user.bio)

    # Check if the first 3 posts are visible
    user.posts.first(3).each_with_index do |post, index|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50)) # Truncate post body for visibility
    end

    # Check if the "View All Posts" button is visible
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'User clicks on a user post and is redirected to its show page' do
    # Get the user's first post
    post = user.posts.first
  
    # Visit the user's post show page directly
    visit user_post_path(user, post)
  
    # Check if the page is redirected to the post's show page
    expect(page).to have_current_path(user_post_path(user, post))
  end
  

  scenario 'User clicks on "View All Posts" and is redirected to the user post index page' do
    # Click on the "View All Posts" button
    click_on 'See all posts'

    # Check if the page is redirected to the user's post index page
    expect(page).to have_current_path(user_posts_path(user))
  end
end
