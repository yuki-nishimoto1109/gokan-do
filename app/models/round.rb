class Round < ApplicationRecord
  belongs_to :room
  has_many :answers,      dependent: :destroy
  has_many :results,      dependent: :destroy
  has_many :votes,        dependent: :destroy
  has_many :join_rounds,  dependent: :destroy
  has_many :users, through: :join_rounds
end
