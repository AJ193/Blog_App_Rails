require 'rails_helper'

RSpec.feature 'User post index page', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    # Create some posts, comments, and likes for the user
    FactoryBot.create_list(:post, 5, author: user)
  end

  scenario 'User sees posts and post details' do
    visit user_posts_path(user)

    # Check if user profile picture is visible
    expect(page).to have_css('img')

    # Check if user's username is visible
    expect(page).to have_content(user.name)

    # Check if post titles and bodies are visible
    user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50))
      expect(page).to have_content(post.comments.first.body) if post.comments.any?
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes.count}") # Truncate post body for visibility
    end

    # Check if the first comments on a post are visible

    # Check if the number of comments and likes on a post is visible

    # Check if the pagination section is visible
    expect(page).to have_css('.pagination')

    # Click on a post and check if it redirects to the post's show page
    first('ul a').click
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
