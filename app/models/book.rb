class Book < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image
	has_attached_file :resource

	validates_attachment_content_type :image, 
	content_type: /^image\/(png|gif|jpeg)/,
	message: "Only image allowed"

	validates_attachment_content_type :resource, 
	content_type: ['application/pdf'],
	message: "Only pdf allowed"


	validates :image, attachment_presence: true
	validates :resource, attachment_presence: true
end
