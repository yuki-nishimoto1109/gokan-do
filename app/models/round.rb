class Round < ApplicationRecord
  belongs_to :room
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many :join_rounds, dependent: :destroy
  has_many :users, through: :join_rounds

  def user_answer(user)
    answer = answers.find_by(user_id: user.id)
    unless answer.present?
      answer = answers.new()
      answer.user_id = user.id
      answer.hand = select_hands
      answer.save
    end
    return answer
  end

private

  def select_hands
    hiraganas = [*'あ'..'ん']
    result = hiraganas.sample(10).join()
    return result
  end

end
