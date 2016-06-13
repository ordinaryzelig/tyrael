# To style this view include its stylesheet at the top of each controller's
# stylesheet that is going to use it:
#   class SomeStylesheet < ApplicationStylesheet
#     include StepStylesheet

# Another option is to use your controller's stylesheet to style this view. This
# works well if only one controller uses it. If you do that, delete the
# view's stylesheet with:
#   rm app/stylesheets/step_stylesheet.rb

module StepStylesheet

  STEP_HEIGHT = 20

  def step(st)
    st.frame = {h: STEP_HEIGHT}
  end

  def led(st)
    st.frame = {h: STEP_HEIGHT, w: STEP_HEIGHT}
    st.font = font.medium
    st.background_color = color.light_gray
    st.color = color.black
  end

end
