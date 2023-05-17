# == Schema Information
#
# Table name: pantries
#
#  id          :integer          not null, primary key
#  item        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
class Pantry < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :category, required: true, class_name: "Category", foreign_key: "category_id", counter_cache: true
end
