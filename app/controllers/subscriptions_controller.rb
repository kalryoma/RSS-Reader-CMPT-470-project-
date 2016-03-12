class SubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def list
        @userid=current_user.id

        # Get subscription list
        @subscriptionslist=Subscription.where("user_id=?",@userid)

        # Set initializaion number
        @counter=-1
        @feedlist=Array.new

        # Add feed info to feedlist
        @subscriptionslist.each do |subscription|
            @counter+=1
            @feedlist[@counter]=Feed.where("id=?",subscription.feed_id)
        end
    end

    def add

        # Save feed in users subscription list

        @feed_id=params[:subscription]
        @feed_id=@feed_id[:feed_id]
        @user_id=current_user.id

        # Add to subscription

        @subscriptiontemp=Subscription.new()
        @subscriptiontemp.feed_id=@feed_id
        @subscriptiontemp.user_id=@user_id
        @subscriptiontemp.save

        redirect_to :action=>:list
    end

    def delete

        # Delete subscription from DB

        @userid=current_user.id
        @feedid=params[:subscription][:feed_id]
        @feed=Subscription.where("user_id=? and feed_id=?", @userid, @feedid)
        @subscription=Subscription.find_by(id: @feed[0].id)
        @subscription.destroy if !@subscription.nil?

        redirect_to :action=>:list
    end

    def ratelist
        # Order the result by ReadNumber
        @feeds=Feed.order("ReadNumber DESC")

        # Put the 10 most readed feed into the output list
        @feedlist=@feeds.take(10)

        # Count the number of output feeds
        @number=0
        (0..9).each do |counter|
            unless @feedlist[counter].nil?
                @number=@number+1
            end
        end
    end

end
