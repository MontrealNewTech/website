# frozen_string_literal: true
class User < ApplicationRecord
  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  validates_presence_of :email
  validates_presence_of :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{first_name} #{last_name}".lstrip
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
