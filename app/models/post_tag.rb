# frozen_string_literal: true

class PostTag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at]
  end
end
