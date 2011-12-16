module ApplicationHelper

  def r_y_g(scale)
    case scale.to_i
    when 1
      "<div id='red'>1</div>"
    when 2
      "<div id='yellow'>2</div>"
    when 3
      "<div id='green'>3</div>"
    when 0
      ""
    end
  end

  def trend_r_y_g(scale, num)
    case scale.to_i
    when 1
      "<div id='red'>"+num.to_s+"</div>"
    when 2
      "<div id='yellow'>"+num.to_s+"</div>"
    when 3
      "<div id='green'>"+num.to_s+"</div>"
    when 0
      ""
    end
  end
end
