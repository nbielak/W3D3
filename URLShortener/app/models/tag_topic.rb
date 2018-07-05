# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint(8)        not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic,
    class_name: :Tagging
end
