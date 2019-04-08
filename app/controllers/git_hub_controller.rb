require 'net/http'
class GitHubController < ApplicationController
    def index
        show_repos
    end

    def search
        @page = (!params[:page].blank? and params[:page].to_i > 0) ? params[:page].to_i : 1
        @repos, total_count = fetch_repos(params[:query], @page)
        #@current_query = params[:query]
        @total_page_count = (total_count || 0)/30
        render :index
    end


    private 
    def show_repos
        @repos ||= []
        @count ||= 0
        @page ||= 1
        @total_page_count ||= 1
    end

    def fetch_repos(q, page)
        return [] if q.blank?

        uri = URI.parse("https://api.github.com/search/repositories?q=#{q.split(" ").flatten.join("+")}&page=#{page}")
        res = JSON.parse(Net::HTTP.get(uri))
        repos = res["items"].map do |item|
            Repository.new(
                :name => item["name"], 
                :url => item["html_url"],
                :description => item["description"],
                :owner => item["owner"]["url"]
            )
        end

        return repos, res["total_count"]
    end
end
