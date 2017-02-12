module Admin
  class AccountsController < Admin::ApplicationController
    def update
      account = Account.find(params[:id])

      if account.update!(account_params)
        redirect_to admin_accounts_path, notice: "Account was successfully updated."
      else
        render :edit, alert: "Accout could not be updated"
      end
    end

    private

    def account_params
      params.require(:account).permit(:admin)
    end
  end
end
