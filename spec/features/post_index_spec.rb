require 'rails_helper'

RSpec.feature 'User post index page', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    # Create some posts, comments, and likes for the user
    FactoryBot.create_list(:post, 5, author: user)
    visit user_posts_path(user)
  end

  scenario 'Check if user profile picture is visible' do
    expect(page).to have_css('img')
  end
  scenario 'Check if users username is visible' do
    expect(page).to have_content(user.name)
  end
  scenario 'Check the number of posts the user has written.' do
    expect(page).to have_content("Number Of posts #{user.posts_counter}")
  end
  scenario 'Check if post titles and bodies are visible' do
    user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text.truncate(50))
      expect(page).to have_content(post.comments.first.body) if post.comments.any?
      expect(page).to have_content("Comments #{post.comments.count}")
      expect(page).to have_content("Likes #{post.likes.count}") # Truncate post body for visibility
    end
  end
  scenario 'Check if the pagination section is visible' do
    expect(page).to have_css('.pagination')
  end
  scenario 'Click on a post and check if it redirects to the posts show page' do
    first('h4 a').click
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
