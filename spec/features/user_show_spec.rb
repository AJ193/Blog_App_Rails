require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  let!(:user) { FactoryBot.create(:user, name: 'TestUser', bio: 'This is a test bio.') }

  before do
    FactoryBot.create_list(:post, 5, author: user)
    visit user_path(user)
  end

  scenario('Check if users profile picture is visible') { expect(page).to have_css('img') }
  scenario 'Check the number of posts the user has written.' do
    expect(page).to have_content("Number Of posts #{user.posts_counter}")
  end
  scenario('Check if users username is visible') { expect(page).to have_content(user.name) }
  scenario('Check if users bio is visible') { expect(page).to have_content(user.bio) }
  scenario 'Check if the first 3 posts are visible' do
    user.posts.first(3).each_with_index do |post, index|
      expect(page).to have_content("Post ##{index + 1}")
      expect(page).to have_content(post.text.truncate(50))
    end
  end
  scenario 'Check if the "View All Posts" button is visible' do
    expect(page).to have_link('View All Posts', href: user_posts_path(user))
  end

  scenario 'User clicks on a user post and is redirected to its show page' do
    first('h4 a').click
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end

  scenario 'User clicks on "View All Posts" and is redirected to the user post index page' do
    click_on 'View All Posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
