require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let!(:miri) { User.create!(email: "miri@gmail.com", password: "password") }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it do
      should validate_length_of(:password).
        is_at_least(6).
        on(:create)
    end
    it { should allow_value(nil).for(:password) }
  end

  describe "associations" do
    it { should have_many(:goals) }
  end

  describe "::find_by_credentials" do
    let!(:dave) { User.create!(email: "dave@gmail.com",
                              password: "password")}

    let!(:miri) { User.create!(email: "miri@yahoo@com",
                              password: "wrong_password")}

    it "should return the user if provided valid credentials" do
      expect(User.find_by_credentials(dave.email, dave.password)).to eq(dave)
    end

    it "should return nil if provided invalid credentials" do
      expect(User.find_by_credentials(dave.email, miri.password)).not_to eq(dave)
    end
  end
end
