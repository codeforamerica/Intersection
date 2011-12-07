module ApplicationHelper

  def r_y_g(scale)
    case scale.to_i
    when 1
      "<div id='red'>1</div>"
    when 2
      "<div id='yellow'>3</div>"
    when 3
      "<div id='green'>3</div>"
    when 0
      "Not Taken"
    end
  end

end
