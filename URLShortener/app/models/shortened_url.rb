# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'SecureRandom'

class ShortenedURL < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visitors,
    through: :visits,
    source: :visitor

  def self.random_code

    short_url = SecureRandom.urlsafe_base64
    while ShortenedURL.exists?(:short_url => short_url)
      short_url = SecureRandom.urlsafe_base64
    end
    short_url
  end

  def self.create!(user, long_url)
    short_url = ShortenedURL.random_code
    options = {short_url: short_url, long_url: long_url, user_id: user.id}

    ShortenedURL.create(options)
  end

  def num_clicks
    self.visitors.length
  end

  def num_uniques
    self.visitors.select(:user_id).distinct.length
  end

  def num_recent_uniques
    self.visitors.select(:user_id).distinct.where({created_at: (Time.now - 10.minutes)..Time.now}).length
  end



end
