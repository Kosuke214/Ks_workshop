# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
