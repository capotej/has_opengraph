module HasOpenGraph

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    # any method placed here will apply to classes, like Hickwall
    def has_opengraph(opts = {})
      cattr_accessor :opengraph

      title = opts[:title] || :title
      type = opts[:type] || :type
      description = opts[:description] || :description
      #guess url here later would be cool
      url = opts[:url] || :url
      image = opts[:image] || :image_url
      site = opts[:site_name] || :site_name
      
      self.opengraph = { :title => title, :type => type, :description => description, :url => url, :image => image, :site_name => site }
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    def draw_opengraph
      str = ''
      self.class.opengraph.each do |k,v|
        if v.class == Symbol
          if res = self.send(v)
            str << '<meta property="og:' << k.to_s << '" content="' << res << '"/>'
          end
        else
          str << '<meta property="og:' << k.to_s << '" content="' << v << '"/>'
        end
      end
      str
    end
    
    def like_button
      url = self.class.opengraph[:url]
      if url
        button = ''
        if url.class == Symbol
          nurl = self.send(url)
        else
          nurl = url
        end
        es_url = CGI.escape(nurl)
        button = '<iframe src="http://www.facebook.com/plugins/like.php?href=' << es_url << '&amp;layout=standard&amp;show_faces=true&amp;width=450&amp;action=like&amp;colorscheme=light" scrolling="no" frameborder="0" allowTransparency="true" style="border:none; overflow:hidden; width:450px; height:px"></iframe>'
        button
      end
    end



  end

end

ActiveRecord::Base.send :include, HasOpenGraph
