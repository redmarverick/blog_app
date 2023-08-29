require 'spec_helper'

RSpec.describe 'User Show Page', type: :feature do
  before do
    @user = User.create(
      id: 900,
      name: 'tester',
      photo: 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      bio: 'test',
      posts_counter: 10
    )
  end
  before do
    @posts = (1..5).map do |i|
      Post.create(
        title: 'Post Title',
        text: 'Post Body',
        author: @user,
        comments_counter: 10,
        likes_counter: 10
      )
    end
  end

  it 'I can see user information and navigate to posts' do
    visit user_path(@user.id)

    expect(page).to have_css("img[src*='https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Posts: #{@user.posts_counter}")
    expect(page).to have_content(@user.bio)

    expect(page).to have_content('Post Title')
    expect(page).to have_content('Post Body'.truncate(50))

    click_link 'See all posts'
    expect(current_path).to include('/users/900')
  end
end
