require 'open-uri'
require 'json'
require "net/https"
require "uri"
require 'faraday'


class PortalController < ApplicationController
  def auth
    
    username = "#{params[:id]}"
    password = "#{params[:password]}"
    res = Faraday.get do |req|
        req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/login.jsp'
    end
    jsessionid = res.headers.to_hash.to_s.split("JSESSIONID=")[1].split(";")[0]
 
    res = Faraday.post do |req|
        req.url 'https://tsso.koreatech.ac.kr/svc/tk/Login.do'
         req.headers = { 'Host' => 'tsso.koreatech.ac.kr',
              'Referer' => 'http://app2.koreatech.ac.kr/mobileApp/sso/login.jsp',
     'Content-Type' => 'application/x-www-form-urlencoded',
              'Cookie' => 'JSESSIONID=' + jsessionid.split(".www")[0] + '; returnUrl=L2ZpbGVib3gvZmlsZWJveEZyb250LmRvP2NtZD1tYWlu; _ga=GA1.3.187598766.1499980133; _gid=GA1.3.79499603.1499980133',
                          'X-Requested-With' => 'kr.ac.koreatech.life' }
     req.body = { :user_id => "#{username}", :user_password => "#{password}", :RelayState => '%2FmobileApp%2Fsso%2Flogin_post_proc2.jsp', :id => 'APP2', :targetId => 'APP2' }
        end
       
        result = res.headers.to_hash.to_s
        location =  URI(result.split('location"=>"')[1].split('"')[0])
       
            res = Faraday.get do |req|
        req.url location
                 req.headers['Host'] = 'app2.koreatech.ac.kr'
              req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
              req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
            req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
          end
         
          jsessionid = res.headers.to_hash.to_s.split("JSESSIONID=")[1].split(";")[0]
         
                      res = Faraday.get do |req|
        req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/login_post_proc2.jsp'
                         req.headers['Host'] = 'app2.koreatech.ac.kr'
              req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
              req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
            req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
          end
         
         
                    res = Faraday.get do |req|
        req.url 'http://app2.koreatech.ac.kr/mobileApp/sso/view2.jsp?login=Y'
              req.headers['Host'] = 'app2.koreatech.ac.kr'
              req.headers['Referer'] = 'http://app2.koreatech.ac.kr/mobileApp/sso/login2.jsp'
              req.headers['Cookie'] = 'JSESSIONID=' + jsessionid
            req.headers['X-Requested-With'] = 'kr.ac.koreatech.life'
          end
          
          if res.body.include? "Logined : Y"
            @hakbun = res.body.split('sEmpNo : ')[1].split(' <br/>')[0]
            @NameK = res.body.split('sUserNmK : ')[1].split(' <br/>')[0].force_encoding('UTF-8')
            
            redirect_to "/users/sign_up"
            #link_to "Sign up", new_registration_path(resource_name)
            # render 블라블라블라
          else
            respond_to do |format|
            format.html { redirect_to :back, notice: '로그인에 실패하였습니다.' }
          end
      end
    
  end

  def login
  end
end
