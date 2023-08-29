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

    expect(page).to have_content(@user.name)
    expect(page).to have_content("Posts: #{@user.posts_counter}")

    first(:css, 'a', text: /Post Title/).click
    expect(current_path).to include('/users/250/posts')
    expect(page).to have_content('Post Title', minimum: 1)
    expect(page).to have_content('Post Title', minimum: 1)
    expect(page).to have_content('Comments: 10')
    expect(page).to have_content('Likes: 10')
  end
end
