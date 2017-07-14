require "spec_helper"

describe "rendering the new template" do
  
  it "displays the Generate Report button" do

    render :template => "sessions/new.html.erb"

    expect(rendered).to have_selector("#generate-report-button")
  
  end

end