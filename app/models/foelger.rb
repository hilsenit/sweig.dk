class Foelger < ApplicationRecord
  belongs_to :followed, class_name: "User"
end
