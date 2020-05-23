# require libraries/modules here
# This just opens a file and reads it into a variable
require "nokogiri"
require "pry"



def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  
projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  projects
end

# line 11 with the loop is saying that each one of the projects has been put
  #into an array and we are going to go over each of them and have the projects become a key, then put the title as a value after
  #making each of them a symbol to put them into the hash of all projects
create_project_hash
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value

#description: project.css("p.bbcard_blurb").text
#location: project.css("ul.project-meta span.location-name").text
#percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
