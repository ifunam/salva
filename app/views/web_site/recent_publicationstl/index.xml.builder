xml.instruct!
xml.data do
  @data.each do |event|
    @month = case event.month
      when nil
        'Jan'
      when 1
        'Jan'
      when 2
        'Feb'
      when 3
        'Mar'
      when 4
        'Apr'
      when 5
        'May'
      when 6
        'Jun'
      when 7
        'Jul'
      when 8
        'Aug'
      when 9
        'Sep'
      when 10
        'Oct'
      when 11
        'Nov'
      when 12
        'Dec'
      else
        'Jan'
    end
    @date = @month +' 01 ' +event.year.to_s+' 00:00:00 GMT-0600'
    xml.event(:start => @date, :title => event.title, :link=>event.url) do
      xml.text! event.authors+', '+event.journal.name+', '+event.journal.country_name
      xml.a('online',:href=>event.url)
=begin
      xml.url event.url
      xml.users do
        event.user_ids.each do |user|
          xml.user do
            @cur_user = User.find_by_id(user)
            xml.user @cur_user.fullname_or_email
            xml.adscription @cur_user.adscription_name
          end
        end
      end
=end
    end #do event
  end
end
