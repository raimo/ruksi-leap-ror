Rails.application.routes.draw do

  class XHRConstraint
    def matches?(request)
      !request.xhr? && !(request.url =~ /\.json$/ && ::Rails.env == 'development')
    end
  end
  match '(*url)' => 'recordings#index', :via => [:get], :constraints => XHRConstraint.new

  resources :recordings
  root 'recordings#index'

end
