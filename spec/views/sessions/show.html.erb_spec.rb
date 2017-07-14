require "spec_helper"

describe "rendering the show template" do
  
  it "displays a funnel chart" do

    render :template => "sessions/show.html.erb"

    expect(rendered).to have_selector("#funnel-chart-container")
  
  end

end