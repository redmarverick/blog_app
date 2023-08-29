require 'spec_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @users = (1..5).map do |i|
      user = User.create(
        name: 'tester',
        photo: 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
        bio: 'test',
        posts_counter: 10
      )
    end
  end

  it 'I can see user information and click on a user' do
    visit users_path

    first(:css, 'a', text: /tester/).click
    expect(current_path).to include('/users')

    expect(page).to have_content('tester')
    expect(page).to have_css("img[src*='https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png']")
    expect(page).to have_content('Posts: 10')
  end
end
