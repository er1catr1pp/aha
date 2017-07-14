require 'rails_helper'

RSpec.feature "Session", :type => :feature do

  scenario "Show the funnel chart for the current session" do
    
    session_instance = FactoryGirl.create(:session)
    page.set_rack_session(:current_session_id => session_instance.id)
    
    visit "/sessions/new"

    click_link "Funnel Report"

    expect(page).to have_text("Your Aha! Funnel Report")

  end

end