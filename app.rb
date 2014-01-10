# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class Project < ActiveRecord::Base
end

get "/projects" do
  content_type :json
  @counters = Project.order("created_at DESC")
  @counters.map {|x| {:project => x.project,:used_by => x.used_by}}.to_json
end

get "/project/:name" do
  @counter = Project.find_by({:project=> params[:name]})

  if @counter.nil?
    {:error => 'no project with that name'}.to_json
  else
    if(@counter.used_by.nil?)
      {:status => 'free'}.to_json
    else
      {:status =>'used', :used_by=> @counter.used_by}.to_json
    end
  end
end

get "/project/:name/get/:user" do
  @counter = Project.find_by({:project=> params[:name]})
  if @counter.nil?
    {:error => 'no project with that name'}.to_json
  else
    if params[:name].nil?
      {:error => 'invalid name'}.to_json
    else
      @counter.used_by=params[:user]
      @counter.save
      {:status => 'OK'}.to_json
    end
  end

end