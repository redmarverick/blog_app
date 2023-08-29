require 'spec_helper'

RSpec.describe 'User Post Index Page', type: :feature, js: true do
  let(:user_id) { 250 } # Set the desired user ID

  before do
    @user = User.create(id: user_id, photo: 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                        name: 'testuser', bio: 'test', posts_counter: 10)

    @posts = (1..10).map do |i|
      Post.create(
        title: 'Post Title',
        text: 'Post Body',
        author: @user,
        comments_counter: 10,
        likes_counter: 10
      )
    end
  end

  it 'I can see post information and click on a post' do
    visit user_posts_path(user_id)

    expect(page).to have_content(@user.name) # test if user name was loaded
    expect(page).to have_content("Posts: #{@user.posts_counter}") # test if posts counter was loaded
    if @posts.count > 1 # Test if there is pagination when there are more posts than fit on the view.
      expect(page).to have_content('Post Title', maximum: 2)
      expect(page).to have_content('Next Page')
    else
      expect(page).to have_content('Post Title', maximum: 1)
    end
    expect(page).to have_content('Post Title', minimum: 1)
    expect(page).to have_css('img.w-full.h-full.rounded-full') # Test to verify user's profile picture.
    expect(page).to have_content('Post Body', minimum: 1) # Test that assert you can see some of the post's body.
    expect(page).to have_content('Comments: 10') # test to check if the comments counter was loaded
    expect(page).to have_content('Likes: 10') # test to check if the likes counter was loaded

    click_link('Post Title', match: :first)
    expect(page).to have_current_path(%r{/users/250/posts/\d+}) # Test if after the click it opens a post
  end
end
