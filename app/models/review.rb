class Review < ApplicationRecord

  # create the association of the foreign key
  belongs_to :idea
  belongs_to :user

  #make the presence of body text mandatory
  validates :body, presence: true
end
