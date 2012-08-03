class Clerk::Log
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message
  field :level, :type => Symbol

  belongs_to :logable, :polymorphic => true

end
