class Vote < ApplicationRecord
  belongs_to :question
  belongs_to :user  

  # Godkend denne stemme, hvis question_id er unikt for stemmer med dette user_id
  validates_uniqueness_of :question_id, scope: :user_id
end
