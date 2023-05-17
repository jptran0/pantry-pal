# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string
#  pantries_count :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Category < ApplicationRecord
  has_many  :pantries, class_name: "Pantry", foreign_key: "category_id", dependent: :nullify
end
