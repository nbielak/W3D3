# == Schema Information
#
# Table name: taggings
#
#  id     :bigint(8)        not null, primary key
#  topic  :string           not null
#  url_id :integer          not null
#

class Tagging < ApplicationRecord
  belongs_to :tag,
    primary_key: :id,
    foreign_key: :topic,
    class_name: :TagTopic

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedURL
end
