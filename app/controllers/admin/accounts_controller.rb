module Admin
  class AccountsController < Admin::ApplicationController
    def update
      account = Account.find(params[:id])

      if account.update(admin: from_param)
        redirect_to admin_accounts_path, notice: t('flash.accounts.success')
      else
        flash[:alert] = t('flash.accounts.failure')
        render :edit
      end
    end

    private

    def account_params
      params.require(:account).permit(:admin)
    end

    def from_param
      account_params[:admin] == "true"
    end
  end
end
