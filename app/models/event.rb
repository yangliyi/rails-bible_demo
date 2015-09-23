class Event < ActiveRecord::Base
  validates_presence_of :name
  has_many :attendees
  has_many :event_groupships
  has_many :group, through: :event_groupships
  has_one :location

  belongs_to :category
end
