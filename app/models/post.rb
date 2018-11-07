# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  published  :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#

class Post < ApplicationRecord
  belongs_to :author, class_name: 'Admin'

  scope :default_order, -> { order(:title) }
  scope :published, -> { where(published: true) }
  scope :search, ->(query) do
    if query.present?
      query = sanitize_sql_like(query)
      query = query.tr('?', '_').tr('*', '%')
      where('title LIKE ?', "%#{query}%")
    else
      self
    end
  end
end
