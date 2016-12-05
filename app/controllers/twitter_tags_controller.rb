class TwitterTagsController < ApplicationController
  layout "instagram"

  def approve
    tag = TwitterTag.find(params[:twitter_tag_id])
    tag.toggle_approve if tag
    redirect_to twitter_tags_admin_path
  end

  # GET /twitter_tags/collect
  # GET /twitter_tags/collect.json
  def collect
    hashtag = "#"+ params[:hashtag] if params[:hashtag].present?
    if hashtag.present?
      search = $twitter.search(hashtag, :include_rts => false)
      tags = search.collect.map{|tw|
        if tw.media && tw.media.present?
          media = tw.media.first
          {tweet_id: tw.id.to_s, tweet_url: media.expanded_url.to_s, media_url: media.media_url.to_s}
        end
      }
      tags.reject!{|x| x == nil}
    end

    @twitter_tags = TwitterTag.create(tags)

    redirect_to twitter_tags_admin_path
  end

  # GET /twitter_tags/admin
  # GET /twitter_tags/admin.json
  def admin
    @twitter_tags = TwitterTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twitter_tags }
    end
  end

  # GET /twitter_tags
  # GET /twitter_tags.json
  def index
    @twitter_tags = TwitterTag.approved

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twitter_tags }
    end
  end

  # GET /twitter_tags/1
  # GET /twitter_tags/1.json
  def show
    @twitter_tag = TwitterTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @twitter_tag }
    end
  end

  # GET /twitter_tags/new
  # GET /twitter_tags/new.json
  def new
    @twitter_tag = TwitterTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @twitter_tag }
    end
  end

  # GET /twitter_tags/1/edit
  def edit
    @twitter_tag = TwitterTag.find(params[:id])
  end

  # POST /twitter_tags
  # POST /twitter_tags.json
  def create
    @twitter_tag = TwitterTag.new(params[:twitter_tag])

    respond_to do |format|
      if @twitter_tag.save
        format.html { redirect_to @twitter_tag, notice: 'Twitter tag was successfully created.' }
        format.json { render json: @twitter_tag, status: :created, location: @twitter_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @twitter_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /twitter_tags/1
  # PUT /twitter_tags/1.json
  def update
    @twitter_tag = TwitterTag.find(params[:id])

    respond_to do |format|
      if @twitter_tag.update_attributes(params[:twitter_tag])
        format.html { redirect_to @twitter_tag, notice: 'Twitter tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @twitter_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_tags/1
  # DELETE /twitter_tags/1.json
  def destroy
    @twitter_tag = TwitterTag.find(params[:id])
    @twitter_tag.destroy

    respond_to do |format|
      format.html { redirect_to twitter_tags_url }
      format.json { head :no_content }
    end
  end
end
