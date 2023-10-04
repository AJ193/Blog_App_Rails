require 'rails_helper'

RSpec.feature 'Post show page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  before do
    # Create comments and likes for the post
    FactoryBot.create_list(:comment, 3, post:)
    FactoryBot.create_list(:like, 2, post:)
  end

  scenario 'User sees post details' do
    visit user_post_path(user, post)

    # Check if post's title is visible
    expect(page).to have_content(post.title)

    # Check if the author's username is visible
    expect(page).to have_content(user.name)

    # Check if the number of comments is visible
    expect(page).to have_content("Comments: #{post.comments_counter}")

    # Check if the number of likes is visible
    expect(page).to have_content("Likes: #{post.likes_counter}")

    # Check if the post's body is visible
    expect(page).to have_content(post.text)

    # Check if usernames of commentors are visible
    post.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
      expect(page).to have_content(comment.text)
    end

    # Check if comments left by commentors are visible
  end
end
