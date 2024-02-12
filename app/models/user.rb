class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'is invalid. Input English letters' } do
    validates :nickname
    validates :gender
  end
  with_options presence: true, format: { with: /\A[0-9０-９]+\z/, message: 'is invalid. Input numbers' } do
    validates :age
  end
end
