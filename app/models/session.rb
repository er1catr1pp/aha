class Session < ApplicationRecord

  validates_presence_of :token

  attr_encrypted :token, key: :encryption_key

  # retrieve all ideas from the Aha! API each time
  # to avoid storing the user's Aha! data
  def ideas
    token_hash = JSON.parse(token)

    # retrieve the first page of ideas
    pages = [ideas_page(token_hash, 1)]

    # check pagination to see if there is more data
    total_pages = pages[0]["pagination"]["total_pages"]

    # retrieve any additional pages
    (2..total_pages).each do |page_number|
      pages << ideas_page(token_hash, page_number)
    end

    # get the ideas from the pages
    all_ideas = pages.collect{|page| page["ideas"]}.flatten

  end

  # get one page of ideas from the Aha! API
  def ideas_page(token_hash, page_number)

    response = Aha::Token.from_hash(token_hash).get("/api/v1/ideas?page=#{page_number}").parsed
    
  end

  # return a hash of the number of ideas grouped by status
  # e.g. {"needs review" => 10, "already exists" => 1, ...}
  def ideas_by_status

    # get all the ideas 
    # (only do this once since we're not persisting ideas)
    all_ideas = ideas

    # get the unique list of statuses for all ideas
    statuses = ideas.collect{|idea| idea["workflow_status"]["name"].downcase}.compact.uniq

    # calculate the frequency of each status
    all_ideas_by_status = {}
    statuses.each do |status|
      all_ideas_by_status[status.gsub(" ","_")] = ideas.select{|idea| idea["workflow_status"]["name"].downcase == status}.size
    end

    all_ideas_by_status

  end

  # calculate funnel report data for ideas by status
  def idea_status_funnel

    # statuses in from top to bottom in the funnel
    funnel_statuses = [
      "needs_review", 
      "future_consideration", 
      "planned", 
      "shipped"
    ]

    # retrieve the number of ideas by status
    # the statuses "already exists" and "will not implement" are ignored
    # since they do not funnel into the lowest order "shipped" status
    funnel_ideas_by_status = ideas_by_status.select{|status, frequency| funnel_statuses.include? status}

    # total number of ideas used for the funnel
    total_count = funnel_ideas_by_status.values.sum

    # calculate the percentage of ideas in each funnel section
    # values are in percentage points i.e. 3.0 for 3%
    funnel_percentages = {}

    # calculation from bottom up for ease
    total_percentage = 0
    funnel_statuses.reverse.each do |status|

      # each iteration adds it's percentage to the total percentage
      # and the funnel grows upward to 100% at the top
      current_percentage = 100 * funnel_ideas_by_status[status].to_f / total_count
      total_percentage += current_percentage
      funnel_percentages[status] = total_percentage.round(1)
    
    end

    funnel_percentages

  end

  # encryption key to keep session tokens secure
  def encryption_key
    Rails.application.secrets[:encryption_key]
  end

end
