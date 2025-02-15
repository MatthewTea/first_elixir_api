defmodule MatthewApiWeb.AccountController do
  use MatthewApiWeb, :controller
  alias MatthewApiWeb.Auth.{Guardian, ErrorResponse}
  alias MatthewApi.{Accounts, Accounts.Account, Users.User, Users}
  import MatthewApiWeb.Auth.AuthorizedPlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback MatthewApiWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hashed_password"])
    end
  end

  def sign_in(conn, %{"email" => email, "hashed_password" => hashed_password}) do
    authorize_account(conn, email, hashed_password)
  end

  defp authorize_account(conn, email, hashed_password) do
    case Guardian.authenticate(email, hashed_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show_with_token, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)
    {:ok, account, new_token} = Guardian.authenticate(token)

    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render(:show_with_token, %{account: account, token: new_token})
  end

  def sign_out(conn, %{}) do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:show_with_token, %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_full_account!(id)
    render(conn, :show_full_account, account: account)
  end

  def current_account(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:show_full_account, account: conn.assigns.account)
  end

  def update(conn, %{"current_hash" => current_hash, "account" => account_params}) do
    case Guardian.validate_password(current_hash, conn.assigns.account.hash_password) do
      true ->
        {:ok, account} = Accounts.update_account(conn.assigns.account, account_params)

        render(conn, :show, account: account)

      false ->
        raise ErrorResponse.Unauthorized, message: "Password Incorrect."
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
