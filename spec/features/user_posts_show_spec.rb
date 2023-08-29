require 'spec_helper'

RSpec.describe 'Post Show Page', type: :feature, js: true do
  before do
    @user = User.create(
      name: 'tester',
      photo: 'test_user.jpg',
      bio: 'test'
    )
    @post = Post.create(
      title: 'Test Post',
      text: 'This is a test post body',
      author: @user,
      comments_counter: 3
    )
    @comments = [
      Comment.create(author: @user, post: @post, text: 'Comment 1'),
      Comment.create(author: @user, post: @post, text: 'Comment 2'),
      Comment.create(author: @user, post: @post, text: 'Comment 3')
    ]

    allow(User).to receive(:find).with(@user.id.to_s).and_return(@user) # Stub User.find
  end

  it 'I can see post information and comments' do
    visit user_post_path(user_id: @user.id.to_s, id: @post.id)

    expect(page).to have_content(@post.title) # THIS IS THE POST TITLE CHECKING
    expect(page).to have_content(@post.author.name) # THIS IS THE POST AUTHOR (WHO WROTE THE POST) CHECKING
    expect(page).to have_content("Comments: 3") # THIS IS THE POST COMMENTS CHECKING
    expect(page).to have_content("Likes: 0") # THIS IS THE POST LIKES CHECKING
    expect(page).to have_content(@post.text) # THIS IS THE POST BODY CHECKING

    @comments.each do |comment|
      expect(page).to have_content(comment.author.name)
      expect(page).to have_content(comment.text)
    end
  end
end
