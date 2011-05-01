# == Schema Information
# Schema version: 20110501000033
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    def self.followed_by(user)
      # followed_ids = user.following.map(&:id).join(", ")
      followed_ids = %(select followed_id
                       from relationships
                       where follower_id = :user_id)
      where("user_id in (#{followed_ids}) or user_id = :user_id",
            { :user_id => user })
    end
end
