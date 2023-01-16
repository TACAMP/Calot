class CampTool < ApplicationRecord

  belongs_to :post

  validates :tool_name , presence: true
end
