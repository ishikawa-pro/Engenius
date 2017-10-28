require 'nokogiri'
require 'mechanize'

module Hb_provide_lib::HTML_provide_module
    def get_html(url)
        agent = Mechanize.new
        agent.user_agent_alias ="Windows IE 9"
        #proxy環境下の場合
        #agent.set_proxy('192.168.10.30', 8080)
        #Mechanizeでhtml情報を取得してnokogiriに渡した値を返す
        begin
            response = agent.get(url)
            return Nokogiri::HTML(response.content.toutf8)
        rescue => e
            p e.message
            return nil
        end
    end
    module_function :get_html
    
end
