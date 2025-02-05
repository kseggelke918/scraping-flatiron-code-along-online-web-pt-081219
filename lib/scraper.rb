require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    @doc = Nokogiri::HTML(html)
  end 
  
  def get_courses
    self.get_page.css('.post')
  end 
  
  def make_courses
    self.get_courses.each do |course|
      c = Course.new 
      c.title = course.css('h2').text 
      c.schedule = course.css('.date').text 
      c.description = course.css('p').text 
    end 
  end 
end




