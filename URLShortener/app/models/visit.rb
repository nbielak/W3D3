# == Schema Information
#
# Table name: visits
#
#  id           :bigint(8)        not null, primary key
#  short_url_id :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ApplicationRecord
  def self.record_visit!(user, shortened_url)
    options = {user_id: user.id, short_url_id: shortened_url.id}
    Visit.new(options)
  end

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :visited_urls,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedURL

end
