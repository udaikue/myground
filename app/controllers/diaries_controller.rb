# frozen_string_literal: true

class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])

    if @diary.update(diary_params)
      redirect_to diaries_path
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:comment, :open)
  end
end
