# frozen_string_literal: true

module Public
  class SessionsController < Devise::SessionsController
    before_action :user_state, only: [:create]

    # ↓rubocopエラー対策
    def create
      super
      create_internal
    end

    def create_internal; end
    # ↑rubocopエラー対策

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to user_path(current_user), notice: 'ゲストユーザとしてログインしました。'
    end

    protected

    # 退会しているかを判断するメソッド
    def user_state
      ## 【処理内容1】 入力されたemailからアカウントを1件取得
      @user = User.find_by(email: params[:user][:email])
      ## アカウントを取得できなかった場合、このメソッドを終了する
      return unless @user

      ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && (@user.status == false)
        flash[:notice] = '退会済みです。再度ご登録をしてご利用ください。'
        redirect_to new_user_registration_path
        # statusの値がtrueだった場合→createアクションを実行させる＝そのまま処理
      end
    end
  end
end
