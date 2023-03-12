# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def hidden
    self.comment_text = 'こちらのコメントは不適切な内容が含まれている可能性があるため、管理者により表示を規制されております。'
  end
end
