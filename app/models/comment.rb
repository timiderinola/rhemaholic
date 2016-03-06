class Comment < ActiveRecord::Base
    belongs_to :micropost, touch: true
    belongs_to :user
end
