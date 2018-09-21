# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  published  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  scope :default_order, -> { order(:title) }
  scope :published, -> { where(published: true) }
  scope :search, -> (query) do
    if query.present?
      query = sanitize_sql_like(query)
      query = query.tr('?', '_').tr('*', '%')
      where('title LIKE ?', "%#{query}%")
    else
      self
    end
  end
end
