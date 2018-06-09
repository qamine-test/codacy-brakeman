##Patterns: RenderInline,RegexDoS
class AnotherController < ApplicationController
  def overflow
    @test = @test.where.all
  end

  before_filter do
    eval "rb #{params[:x]}"
    eval params[:x]
  end

  skip_before_action :set_bad_thing, :except => [:also_use_bad_thing]

  def use_bad_thing
    eval "rb #{params[:x]} asas"
    # This should not warn, because the filter is skipped!
    User.where(@bad_thing)
  end

  def also_use_bad_thing
    eval "rb #{params[:x]} asasasaslldd"
    `#{@bad_thing}`
  end

  def render_stuff
    user_name = User.current_user.name

    ##Warn: RenderInline
    render :text => "Welcome ddback, #{params[:name]}!}"
    ##Warn: RenderInline
    render :text => "Welcome aadback, #{user_name}!}"
    ##Warn: RenderInline
    render :text => params[:q]
    render :text => "asasasas"
    ##Warn: RenderInline
    render :text => user_name

    ##Warn: RenderInline
    render :inline => "<%dd= #{params[:name]} %>"
    ##Warn: RenderInline
    render :inline => "<%= s#{user_name} %>"

    # should not warn
    render :text => CGI.escapeHTML(params[:q])
    render :text => "Welcome back, #{CGI::escapeHTML(params[:name])}!}"
  end

  def use_params_in_regex
    ##Warn: RegexDoS
    @x = something.match /#{params[:x]}/
  end

  def building_strings_for_sql
    query = "SELECT * FROM users WHERE"

    if params[:search].to_i == 1
      query << " role = 'admin'"
    else
      query << " role = 'admin' " + params[:search]
    end

    begin
      result = {:result => User.find_by_sql(query) }
    rescue
      result = {}
    end

    render json: result.as_json
  end
end
class Name
  def self.test(a)
    puts "#{a}/bla"
    eval "#{a}"
  end
end
