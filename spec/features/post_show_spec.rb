require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  before do
    # Create comments and likes for the post
    FactoryBot.create_list(:comment, 3, post: post)
    FactoryBot.create_list(:like, 2, post: post)
    visit user_post_path(user, post)
  end

  scenario 'Check if posts title is visible' do
    expect(page).to have_content(post.title)
  end
  scenario 'Check if the authors username is visible' do
    expect(page).to have_content(user.name)
  end
  scenario 'Check if the number of comments is visible' do
    expect(page).to have_content("Comments #{post.comments_counter}")
  end
  scenario 'Check if the number of likes is visible' do
    expect(page).to have_content("Likes #{post.likes_counter}")
  end
  scenario 'Check if the posts body is visible' do
    expect(page).to have_content(post.text)
  end
  scenario 'Check if usernames of commentors are visible' do
    post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
      expect(page).to have_content(comment.body)
    end

    # Check if comments left by commentors are visible
  end
end
