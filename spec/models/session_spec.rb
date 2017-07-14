require 'rails_helper'

RSpec.describe Session, type: :model do
  
  let(:session_instance) { FactoryGirl.create(:session) }

  # factory presence 
  it "has a valid factory" do
    expect(session_instance).to be_valid
  end

  # use of attr_encrypted to encrypt
  it {should encrypt(:token) }

  # basic validations
  describe "ActiveModel validations" do

    # token is required
    # NOTE: currently causes a deprecation which is marked to be fixed
    # by the next release of attr_encrypted
    it { expect(session_instance).to validate_presence_of(:token) }

  end

  # databse columns/indexes
  describe "ActiveRecord associations" do

    # the token needs to be encrypted and be a text field
    it { expect(session_instance).to have_db_column(:encrypted_token).of_type(:text)}

  end


end