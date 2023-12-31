require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Random title', text: 'Random text', author_id: 1, comments_counter: 0, likes_counter: 0) }

  before do
    subject.save
    @user1 = User.create(
      name: 'Monika',
      photo: 'https://google.cl',
      bio: 'Singer',
      posts_counter: 0
    )
    @user1.save
  end

  it 'should validate the presence of title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should validate the title to be at most 250 characters long' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer greater than or equal to 0' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer greater than or equal to 0' do
    subject.likes_counter = 'string'
    expect(subject).to_not be_valid
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should belong to an author' do
    assc = described_class.reflect_on_association(:author)
    expect(assc.macro).to eq :belongs_to
    expect(assc.options[:class_name]).to eq 'User'
  end

  it 'should have many comments' do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many likes' do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
  end

  it 'update user posts counter after creation' do
    @post1 = Post.create(
      title: 'Raondom title 2',
      text: 'random text 2',
      author_id: @user1.id,
      comments_counter: 0,
      likes_counter: 0
    )
    user1 = User.find(@user1.id)
    expect(user1.posts_counter).to eq(1)
  end
  # rubocop:disable Metrics/BlockLength
  it 'returns recent comments' do
    @post1 = Post.create(
      title: 'Random title 2',
      text: 'random text 2',
      author_id: @user1.id,
      comments_counter: 0,
      likes_counter: 0
    )
    Comment.create(
      text: 'Text 1',
      author_id: @user1.id,
      post_id: @post1.id
    )
    Comment.create(
      text: 'Text 2',
      author_id: @user1.id,
      post_id: @post1.id
    )
    Comment.create(
      text: 'Text 3',
      author_id: @user1.id,
      post_id: @post1.id
    )
    Comment.create(
      text: 'Text 4',
      author_id: @user1.id,
      post_id: @post1.id
    )
    Comment.create(
      text: 'Text 5',
      author_id: @user1.id,
      post_id: @post1.id
    )
    Comment.create(
      text: 'Text 6',
      author_id: @user1.id,
      post_id: @post1.id
    )

    recent_comments = @post1.five_most_recent_comments
    expect(recent_comments.size).to eq(5)

    recent_comments = @post1.five_most_recent_comments
    expect(recent_comments.size).to eq(5)
  end
  # rubocop:enable Metrics/BlockLength
end
