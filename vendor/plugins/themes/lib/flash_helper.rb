module FlashHelper
  
  def display_flash(flash)
    ret = ""
    flash.each do |name, msg|
      if msg.is_a?Array
      	msg.each do |m|
      	  ret << content_tag(:div, m, :class => "flash_#{name}")
      	end
      else
      	ret << content_tag(:div, msg, :id => "flash_#{name}")
      end
    end
    ret
  end
end