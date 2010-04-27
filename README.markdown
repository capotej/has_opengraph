# has_opengraph
Easily generate [facebook opengraph](http://developers.facebook.com/docs/opengraph) data from your models

### Installation
From your rails directory

    script/plugin install git://github.com/destructoid/has_opengraph.git

### Example Usage
Then you can just use it like so:
    # map opengraph values to fields/methods in your model
    class Movie < ActiveRecord::Base
      has_opengraph :title => :name,
                    :url => :get_url,
                    :image => :cover_image_url,
                    :description => :desc,
                    :type => "movie",
                    :site_name => "moviesite.com"
      def get_url
        self.permalink
      end
    end

    # yield to a :fb block in your layout for the opengraph tags we'll be drawing
    <html>
      <head>
        <%= yield :fb %>
      </head>
      <body>
        <%= yield %>
      </body>
    </html>    

    # pass the opengraph meta tags to our content_for block
    <% content_for :fb do %>
      @movie.draw_opengraph
    <% end %>
    <div class="movie">
      <h1><%= @movie.title %></h1>
    </div>
    ...

    # now you can display the like button for any model instance 
    <div class="movie-comments">
      <span><%= @movie.like_button %></span>
    </div>

### License

Copyright (c) 2010 ModernMethod, released under the MIT license
