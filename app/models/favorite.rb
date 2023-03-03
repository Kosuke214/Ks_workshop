# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :posts
  belongs_to :user
end
