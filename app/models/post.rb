class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture, PictureUploader
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 255 }
    validates :user_id, presence: true
    validate  :picture_size
    
    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
